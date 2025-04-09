import 'package:drift/drift.dart';
import 'package:selene/core/database/tables/authors_table.dart';
import 'package:selene/core/database/tables/works_table.dart';

@DataClassName('WorkAuthorLink')
class WorkAuthors extends Table {
  @override
  String get tableName => 'work_authors';

  @override
  Set<Column> get primaryKey => {workID, authorID};

  // Foreign key to the Works table
  IntColumn get workID =>
      integer().references(Works, #id, onDelete: KeyAction.cascade)();

  // Foreign key to the Authors table
  IntColumn get authorID => integer().references(Authors, #id)();
}
