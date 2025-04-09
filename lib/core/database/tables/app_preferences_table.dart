import 'package:drift/drift.dart';

class AppPreferences extends Table {
  TextColumn get key => text().customConstraint('NOT NULL PRIMARY KEY')();
  TextColumn get value => text()();
}
