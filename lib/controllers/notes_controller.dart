import 'package:cipers_cluster/database/drift_database.dart';
import 'package:get/get.dart';

import 'db_controller.dart';

class NotesController extends GetxController {
  final DBController dbController = Get.find();

  NotesController();

  Stream<List<Note>> getNotes(String name) => name.isEmpty ? dbController.notesDao.getNotes().watch() : getNotesByName(name);
  Stream<List<Note>> getNotesByName(String name) => dbController.notesDao.getNotesByName(name).watch();
  Future<int> deleteNoteById(int id) => dbController.notesDao.deleteNoteById(id);
}
