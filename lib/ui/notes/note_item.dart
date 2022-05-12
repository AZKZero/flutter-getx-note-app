import 'dart:developer';

import 'package:cipers_cluster/database/drift_database.dart';
import 'package:cipers_cluster/ui/dialogs/dialog_confirmation.dart';
import 'package:cipers_cluster/ui/extensions/dialog_extensions.dart';
import 'package:cipers_cluster/ui/notes/note_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/notes_controller.dart';

class NoteItem extends StatelessWidget {
  NoteItem({Key? key, required this.note}) : super(key: key);

  final Note note;

  final NotesController _notesController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: InkWell(
        splashColor: Colors.amber,
        // highlightColor: Colors.green,
        onTap: () => Get.to(NotePage(
          note: note,
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 8,
            ),
            Stack(
              clipBehavior: Clip.none,
              alignment: AlignmentDirectional.centerEnd,
              children: [
                Center(
                  child: Text(
                    note.title ?? '',
                    style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      var delete = await Get.dialog(
                          DialogWrapper(
                              child: DialogConfirmation(
                            text: 'Delete?',
                            confirm: 'Delete',
                          )),
                          useSafeArea: true);
                      log(delete.toString());
                      log(note.id.toString());
                      if (delete && note.id != null) {
                        await _notesController.deleteNoteById(note.id!);
                      }
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ))
              ],
            ),
            /*Center(
              child: Text(
                note.title ?? '',
                style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),*/
            const Divider(
              thickness: 1,
              color: Colors.red,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(note.plainText ?? ''),
            ),
            if (note.files?.isNotEmpty == true)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Icon(
                    Icons.attachment,
                    color: Colors.green,
                  )
                ],
              )
          ],
        ),
      ),
    );
  }
}
