import 'package:drift/drift.dart';
import 'package:selene/core/database/tables/works_table.dart';

class Chapters extends Table {
  @override
  String get tableName => 'chapters';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get sourceURL => text().unique()();
  IntColumn get workID =>
      integer().references(Works, #id, onDelete: KeyAction.cascade)();
  TextColumn get title => text()();
  TextColumn get content => text()();
  TextColumn get datePublished => text()();
  IntColumn get wordCount => integer().withDefault(const Constant(0))();
  IntColumn get chapterNumber => integer().withDefault(const Constant(0))();

  // Ensure that the chapter number is unique within the work
  @override
  List<Set<Column>> get uniqueKeys => [
    {workID, chapterNumber},
  ];
}
