import 'package:selene/core/database/mappers/author_mapper.dart';
import 'package:selene/core/database/mappers/chapter_mapper.dart';
import 'package:selene/core/database/mappers/fandom_mapper.dart';
import 'package:selene/core/database/mappers/series_mapper.dart';
import 'package:selene/core/database/mappers/tag_mapper.dart';
import 'package:selene/core/database/models/work.dart';
import 'package:selene/core/database/tables/works_table.dart';

class WorkMapper {
  /// Converts a [Work] table object to a [WorkModel].
  ///
  /// This method MUST be called after the entity has been retrieved from Isar.
  /// It loads the related entities (authors, series, tags, chapters) and maps
  /// them to their respective models.
  static Future<WorkModel> mapToModel(Work work) async {
    // Load related entities concurrently for efficiency
    await Future.wait([
      work.fandoms.load(),
      work.authors.load(),
      work.series.load(),
      work.tags.load(),
      work.chapters.load(),
    ]);

    // Map the loaded entities to their respective models
    final fandomsFuture = Future.wait(
      work.fandoms.map((fandom) => FandomMapper.mapToModel(fandom)),
    );
    final authorsFuture = Future.wait(
      work.authors.map((author) => AuthorMapper.mapToModel(author)),
    );
    final seriesFuture = Future.wait(
      work.series.map((series) => SeriesMapper.mapToModel(series)),
    );
    final tagsFuture = Future.wait(
      work.tags.map((tag) => TagMapper.mapToModel(tag)),
    );
    final chaptersFuture = Future.wait(
      work.chapters.map((chapter) => ChapterMapper.mapToModel(chapter)),
    );

    // Wait for all futures to complete
    final fandoms = await fandomsFuture;
    final authors = await authorsFuture;
    final series = await seriesFuture;
    final tags = await tagsFuture;
    final chapters = await chaptersFuture;

    // Construct the WorkModel
    return WorkModel(
      id: work.id,
      title: work.title,
      sourceURL: work.sourceURL,
      filePath: work.filePath,
      summary: work.summary,
      fandoms: fandoms,
      wordCount: work.wordCount,
      status: work.status,
      coverURL: work.coverURL,
      datePublished: work.datePublished,
      dateUpdated: work.dateUpdated,
      authors: authors,
      series: series,
      tags: tags,
      chapters: chapters,
      readProgress: work.readProgress,
    );
  }

  /// Converts a [WorkModel] to a [Work] table object.
  ///
  /// IMPORTANT: This method ONLY maps the direct fields. Establishing and
  /// saving the relationships (IsarLinks for authors, tags, etc.) MUST be
  /// handled separately within the repository's write transaction logic,
  /// AFTER the related entities have been found/created and saved in Isar.
  static Work mapToTable(WorkModel workModel) {
    // Create a new Work table object
    // Note: The id is set to null here. It will be set by Isar when the entity is saved.
    final workEntity = Work(
      title: workModel.title,
      sourceURL: workModel.sourceURL,
      filePath: workModel.filePath,
      summary: workModel.summary,
      wordCount: workModel.wordCount,
      status: workModel.status,
      coverURL: workModel.coverURL,
      datePublished: workModel.datePublished,
      dateUpdated: workModel.dateUpdated,
      readProgress: workModel.readProgress,
    );

    // If the model has an id, set it on the entity
    // This is important for updating existing entities
    if (workModel.id != null) {
      workEntity.id = workModel.id!;
    }

    // Note: Relationships (IsarLinks) are not set here. They should be handled
    // separately in the repository's write transaction logic.
    return workEntity;
  }
}
