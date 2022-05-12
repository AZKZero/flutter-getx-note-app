import 'dart:convert';
import 'dart:developer';

import 'package:cipers_cluster/controllers/db_controller.dart';
import 'package:cipers_cluster/database/drift_database.dart';
import 'package:cipers_cluster/ui/files/file_item.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:get/get.dart';

class NotePage extends StatelessWidget {
  NotePage({Key? key, this.note}) : super(key: key) {
    textEditingController = TextEditingController(text: note?.title ?? '');
    try {
      _quillController = quill.QuillController(
        document: note?.richText ?? quill.Document.fromJson(jsonDecode("")),
        selection: const TextSelection.collapsed(offset: 0),
      );
    } catch (e) {
      print(e);
      _quillController = quill.QuillController(
        document: quill.Document(),
        selection: const TextSelection.collapsed(offset: 0),
      );
    }
    paths.value = (note?.files ?? List.empty(growable: true)).obs;
  }

  late final quill.QuillController _quillController;
  final DBController _dbController = Get.find();
  late final TextEditingController textEditingController;

  Note? note;
  final FocusNode _focusNode = FocusNode();

  final saving = false.obs;
  List<PlatformFile>? files;
  RxList<String> paths = RxList.empty(growable: true);

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      if (paths.isEmpty == true) {
        paths.value = result.paths.whereType<String>().toList();
      } else {
        paths.addAll(result.paths.whereType<String>().toList());
      }
    } else {
      // User canceled the picker
    }
  }

  void onClear(String path) {
    paths.remove(path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(note != null ? 'Edit Note' : 'New Note'),
        actions: [IconButton(onPressed: pickFile, icon: const Icon(Icons.attachment))],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: textEditingController,
              decoration: const InputDecoration(labelText: 'New Note'),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.07,
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Obx(() => ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 10,
                  ),
                  itemCount: paths.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => FileItem(
                    file: paths[index],
                    onClear: onClear,
                  ),
                )),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                child: Padding(
                    padding: const EdgeInsets.all(8),
                    // child: quill.QuillEditor.basic(controller: _quillController, readOnly: false),
                    child: quill.QuillEditor(
                      controller: _quillController,
                      focusNode: _focusNode,
                      autoFocus: true,
                      padding: EdgeInsets.zero,
                      expands: false,
                      scrollable: true,
                      readOnly: false,
                      scrollController: ScrollController(),
                    )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: quill.QuillToolbar.basic(
              multiRowsDisplay: true,
              showImageButton: false,
              showVideoButton: false,
              controller: _quillController,
              showAlignmentButtons: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Obx(() => ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.blue),
                      onPressed: saving.value
                          ? null
                          : () async {
                              saving.value = true;
                              log(jsonEncode(_quillController.document.toDelta().toJson()), name: "Alt-X");
                              log(jsonEncode(_quillController.document.toPlainText()), name: "Alt-X");

                              var newNote = Note(
                                  id: note?.id,
                                  richText: _quillController.document,
                                  plainText: _quillController.document.toPlainText(),
                                  title: textEditingController.value.text,
                                  files: paths,
                                  created: note?.created ?? DateTime.now(),
                                  modified: DateTime.now());
                              log(newNote.toJsonString());
                              await _dbController.notesDao.insertNote(newNote);
                              Get.back();
                            },
                      child: const Text("Save Note"))),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
