import 'package:cipers_cluster/database/drift_database.dart';
import 'package:drift/web.dart';

AltDriftDatabase constructDb() {
  return AltDriftDatabase(WebDatabase('db'));
}
