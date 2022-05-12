import 'dart:convert';

import 'package:cipers_cluster/database/providers/notes_dao.dart';
import 'package:cipers_cluster/database/tables.dart';
import 'package:drift/drift.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

part 'drift_database.g.dart';

@DriftDatabase(tables: [Notes], daos: [NotesDao])
class AltDriftDatabase extends _$AltDriftDatabase {
  // we tell the database where to store the data with this constructor
  // AltDriftDatabase() : super(_openConnection());
  AltDriftDatabase(QueryExecutor e) : super(e);
  // you should bump this number whenever you change or add a table definition. Migrations
  // are covered later in this readme.
  @override
  int get schemaVersion => 6;

  @override
  MigrationStrategy get migration => MigrationStrategy(onCreate: (Migrator m) {
        return m.createAll();
      }, onUpgrade: (Migrator m, int from, int to) async {
        await m.deleteTable("note");
        await m.createAll();
      });
}

class ListConverter extends TypeConverter<List<String>, String> {
  const ListConverter();

  @override
  List<String>? mapToDart(String? fromDb) => fromDb == null ? null : (jsonDecode(fromDb) as List<dynamic>?)?.cast<String>().toList();

  @override
  String? mapToSql(List<String>? value) => jsonEncode(value);
}

class QuillConverter extends TypeConverter<Document, String> with JsonTypeConverter {
  const QuillConverter(this.plain);

  final bool plain;

  @override
  Document? mapToDart(String? fromDb) => fromDb == null
      ? null
      : plain
          ? quill.Document.fromDelta(Delta()..insert(fromDb))
          : quill.Document.fromJson(jsonDecode(fromDb));

  @override
  String? mapToSql(Document? value) => plain ? value?.toPlainText() : jsonEncode(value?.toDelta().toJson());
}
