import 'package:cipers_cluster/database/providers/notes_dao.dart';
import 'package:cipers_cluster/database/shared_database.dart';
import 'package:get/get.dart';

import '../database/drift_database.dart';

class DBController extends GetxController {
  AltDriftDatabase database = constructDb();

  NotesDao get notesDao => database.notesDao;

/* _initializeDB(Function f) =>
      (database ?? (database = AltDriftDatabase()))
        .obs;*/
}
