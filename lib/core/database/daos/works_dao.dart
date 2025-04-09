import 'package:drift/drift.dart';
import 'package:selene/core/database/database.dart';
import 'package:selene/core/database/tables/authors_table.dart';
import 'package:selene/core/database/tables/chapters_table.dart';
import 'package:selene/core/database/tables/links/work_authors.dart';
import 'package:selene/core/database/tables/links/work_tags.dart';
import 'package:selene/core/database/tables/tags_table.dart';
import 'package:selene/core/database/tables/works_table.dart';
import 'package:selene/models/author_model.dart';
import 'package:selene/models/chapter_model.dart';
import 'package:selene/models/tag_model.dart';
import 'package:selene/models/work_model.dart';
import 'package:selene/features/library/models/work_entity.dart';

part 'works_dao.g.dart';

@DriftAccessor(tables: [Works, Authors, WorkAuthors, Tags, WorkTags, Chapters])
class WorksDao extends DatabaseAccessor<AppDatabase> with _$WorksDaoMixin {
  WorksDao(super.db);

  // -- Read Operations --

  /// Watches all works (including their associated authors and tags).
  Stream<List<WorkEntity>> watchAllWorks() {
    // Define table aliases for clarity (optional but helpful in complex joins)
    final w = alias(works, 'w');
    final wa = alias(workAuthors, 'wa');
    final a = alias(authors, 'a');
    final wt = alias(workTags, 'wt');
    final t = alias(tags, 't');
    final c = alias(chapters, 'c');

    // Select from the Works table
    final query = select(w).join([
      leftOuterJoin(wa, wa.workID.equalsExp(w.id)),
      leftOuterJoin(a, a.id.equalsExp(wa.authorID)),
      leftOuterJoin(wt, wt.workID.equalsExp(w.id)),
      leftOuterJoin(t, t.id.equalsExp(wt.tagID)),
      leftOuterJoin(c, c.workID.equalsExp(w.id)),
    ]);

    // Watch the query for changes
    return query.watch().map((rows) {
      // Process potentially duplicated rows
      final Map<int, WorkEntity> worksMap = {};

      for (final row in rows) {
        final work = row.readTable(w);
        final author = row.readTableOrNull(a); // Nullable due to leftOuterJoin
        final tag = row.readTableOrNull(t); // Nullable due to leftOuterJoin
        final chapter = row.readTableOrNull(c); // Nullable due to leftOuterJoin

        // Get/create the entry for the current work
        final entry = worksMap.putIfAbsent(
          work.id,
          () => WorkEntity(
            work: WorkModel.fromData(work),
            authors: [],
            tags: [],
            chapters: [],
          ),
        );

        // Add author if present and not already added
        if (author != null) {
          final authorSet = entry.authors.map((a) => a.id).toSet();
          if (!authorSet.contains(author.id)) {
            entry.authors.add(AuthorModel.fromData(author));
          }
        }

        // Add tag if present and not already added
        if (tag != null) {
          final tagSet = entry.tags.map((t) => t.id).toSet();
          if (!tagSet.contains(tag.id)) {
            entry.tags.add(TagModel.fromData(tag));
          }
        }

        // Add chapter if present and not already added
        if (chapter != null) {
          final chapterSet = entry.chapters.map((c) => c.id).toSet();
          if (!chapterSet.contains(chapter.id)) {
            entry.chapters.add(ChapterModel.fromData(chapter));
          }
        }

        // Update the map entry with the latest data
      }

      // Convert the map values to a list
      return worksMap.values.toList();
    });
  }
}
