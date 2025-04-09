import 'package:drift/drift.dart';
import 'package:selene/core/database/tables/tags_table.dart';
import 'package:selene/core/database/tables/works_table.dart';

@DataClassName('WorkTagLink')
class WorkTags extends Table {
  @override
  String get tableName => 'work_tags';

  @override
  Set<Column> get primaryKey => {workID, tagID};

  // Foreign key to the Works table
  // If a Work is deleted, delete this link
  IntColumn get workID =>
      integer().references(Works, #id, onDelete: KeyAction.cascade)();

  // Foreign key to the Tags table
  // If a Tag is deleted, delete this link
  IntColumn get tagID => integer().references(Tags, #id)();
}
