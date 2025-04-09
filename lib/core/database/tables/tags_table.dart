import 'package:drift/drift.dart';
import 'package:selene/models/tag_model.dart';

class Tags extends Table {
  @override
  String get tableName => 'tags';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get sourceURL => text().unique()();
  TextColumn get label => text().withLength(min: 1, max: 100)();
  IntColumn get type => intEnum<TagType>()();
}
