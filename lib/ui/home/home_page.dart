import 'package:cipers_cluster/controllers/notes_controller.dart';
import 'package:cipers_cluster/database/drift_database.dart';
import 'package:cipers_cluster/ui/notes/note_item.dart';
import 'package:cipers_cluster/ui/notes/note_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final NotesController _notesController = Get.find();

  final searchValue = "".obs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        floatingActionButton: FloatingActionButton(child: const Icon(Icons.add, color: Colors.white), onPressed: () => Get.to(NotePage())),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                autofocus: false,
                onChanged: (value) => searchValue.value = value,
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Obx(() => StreamBuilder<List<Note>>(
                      stream: _notesController.getNotes(searchValue.value),
                      builder: (context, snapshot) => snapshot.hasData && snapshot.data!.isNotEmpty
                          ? ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) => NoteItem(note: snapshot.data![index], key: Key(snapshot.data![index].id?.toString() ?? '')),
                            )
                          : Text(snapshot.data != null && snapshot.data!.isEmpty ? 'Empty' : 'Loading'),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
