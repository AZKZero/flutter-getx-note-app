import 'package:cipers_cluster/database/drift_database.dart';
import 'package:cipers_cluster/database/tables.dart';
import 'package:drift/drift.dart';

part 'notes_dao.g.dart';

@DriftAccessor(tables: [
  Notes
], queries: {
  'getNotes': 'SELECT * from notes',
  'deleteNoteById': 'DELETE FROM notes WHERE id=:noteId'
  /*, 'getNotesByName': 'SELECT * from notes WHERE title LIKE "%:name%"'*/
})
class NotesDao extends DatabaseAccessor<AltDriftDatabase> with _$NotesDaoMixin {
  NotesDao(AltDriftDatabase database) : super(database);

  insertNote(Note note) async => await into(notes).insertOnConflictUpdate(note);

  SimpleSelectStatement<$NotesTable, Note> getNotesByName(String name) => (select(notes)..where((tbl) => tbl.title.like('%$name%')));
}
