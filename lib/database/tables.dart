import 'package:cipers_cluster/database/drift_database.dart';
import 'package:drift/drift.dart';

class Notes extends Table {
  Column<int?> get id => integer().autoIncrement().nullable()();

  Column<String?> get title => text().nullable()();

  @JsonKey('plain_text')
  Column<String?> get plainText => text().nullable()();

  @JsonKey('rich_text')
  Column<String?> get richText => text().map(const QuillConverter(false)).nullable()();

  Column<String?> get files => text().map(const ListConverter()).nullable()();

  Column<DateTime?> get created => dateTime().nullable()();

  Column<DateTime?> get modified => dateTime().nullable()();
}
