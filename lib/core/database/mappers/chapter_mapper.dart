import 'package:selene/core/database/models/chapter.dart';
import 'package:selene/core/database/tables/chapters_table.dart';

class ChapterMapper {
  /// Converts a [Chapter] table object to a [ChapterModel].
  ///
  /// This method MUST be called after the entity has been retrieved from Isar.
  /// It loads the related entities (work) and maps them to their respective models.
  static Future<ChapterModel> mapToModel(Chapter chapter) async {
    // Construct the ChapterModel
    return ChapterModel(
      id: chapter.id,
      title: chapter.title,
      sourceURL: chapter.sourceURL,
      index: chapter.index,
      wordCount: chapter.wordCount,
      datePublished: chapter.datePublished,
      content: chapter.content,
      summary: chapter.summary,
      startNotes: chapter.startNotes,
      endNotes: chapter.endNotes,
      isRead: chapter.isRead,
    );
  }

  /// Converts a [ChapterModel] to a [Chapter] table object.
  ///
  /// IMPORTANT: This method ONLY maps the direct fields. Establishing and
  /// loading relationships must be handled separately.
  static Chapter mapToTable(ChapterModel chapterModel) {
    // Create a new Chapter table object
    // Note: The id is set to null here. It will be set by Isar when the entity is saved.
    final chapterEntity = Chapter(
      title: chapterModel.title,
      sourceURL: chapterModel.sourceURL,
      index: chapterModel.index,
      wordCount: chapterModel.wordCount,
      datePublished: chapterModel.datePublished,
      content: chapterModel.content,
      summary: chapterModel.summary,
      startNotes: chapterModel.startNotes,
      endNotes: chapterModel.endNotes,
      isRead: chapterModel.isRead,
    );

    // If the model has an id, set it on the entity
    // This is important for updating existing entities
    if (chapterModel.id != null) {
      chapterEntity.id = chapterModel.id!;
    }

    // Note: Relationships (IsarLinks) are not set here. They should be handled
    // separately in the repository's write transaction logic.
    return chapterEntity;
  }
}
