// Example:
// Midoriya Izuku / Uraraka Ochako
// is related to:
// - Midoriya Izuku
// - Uraraka Ochako

import 'package:drift/drift.dart';
import 'package:selene/core/database/tables/tags_table.dart';

@DataClassName('RelatedTagLink')
class RelatedTags extends Table {
  @override
  String get tableName => 'related_tags';

  @override
  Set<Column> get primaryKey => {tagID, relatedTagID};

  // Foreign key to the Tags table
  // If a Tag is deleted, delete this link
  @ReferenceName('TagID')
  IntColumn get tagID =>
      integer().references(Tags, #id, onDelete: KeyAction.cascade)();

  // Foreign key to the Tags table
  // If a Tag is deleted, delete this link
  @ReferenceName('RelatedTagID')
  IntColumn get relatedTagID =>
      integer().references(Tags, #id, onDelete: KeyAction.cascade)();

  // Ensure that tagID and relatedTagID are not the same
  @override
  List<String> get customConstraints => [
    // Use the actual SQL column names here (usually snake_case from Dart camelCase)
    'CHECK (tag_id != related_tag_id)',
  ];
}
