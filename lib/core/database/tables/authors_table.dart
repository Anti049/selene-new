import 'package:drift/drift.dart';

class Authors extends Table {
  @override
  String get tableName => 'authors';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get sourceURL => text().unique()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
}
