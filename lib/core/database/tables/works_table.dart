import 'package:drift/drift.dart';
import 'package:selene/models/work_model.dart';

class Works extends Table {
  @override
  String get tableName => 'works';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get sourceURL => text().unique()();
  TextColumn get title => text().withLength(min: 1, max: 100)();
  TextColumn get summary => text().nullable()();
  IntColumn get status =>
      intEnum<WorkStatus>().withDefault(const Constant(0))();
  IntColumn get wordCount => integer().withDefault(const Constant(0))();
}
