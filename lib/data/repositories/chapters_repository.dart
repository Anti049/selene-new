import 'package:isar/isar.dart';
import 'package:selene/core/database/mappers/chapter_mapper.dart';
import 'package:selene/core/database/models/chapter.dart';
import 'package:selene/core/database/tables/chapters_table.dart';
import 'package:selene/core/database/tables/works_table.dart';

class ChapterRepository {
  final Isar _isar;

  ChapterRepository(this._isar);

  // --- Read Operations ---
  /// Retrieves a chapter by its ID.
  Future<ChapterModel?> getChapterByID(int id) async {
    final chapter = await _isar.chapters.get(id);
    if (chapter == null) return null;
    return ChapterMapper.mapToModel(chapter);
  }

  /// Retrieves all chapters for a given work ID.
  Future<List<ChapterModel>> getChaptersByWorkID(int workID) async {
    final chapters =
        await _isar.chapters
            .filter()
            .work((q) => q.idEqualTo(workID))
            .findAll();
    return Future.wait(chapters.map(ChapterMapper.mapToModel));
  }

  // --- Write Operations ---
  /// Upserts a chapter into the database.
  Future<ChapterModel> upsertChapter(ChapterModel chapter) async {
    final existingChapter = await _isar.chapters.get(chapter.id ?? -1);
    final chapterEntity = ChapterMapper.mapToTable(chapter);
    if (existingChapter != null) {
      // Update existing chapter
      chapterEntity.id = existingChapter.id;
    }

    int chapterID = -1;

    await _isar.writeTxn(() async {
      chapterID = await _isar.chapters.put(chapterEntity);
    });

    // After writing, we can retrieve the full chapter with its ID
    final savedChapter = await _isar.chapters.get(chapterID);
    return ChapterMapper.mapToModel(savedChapter!);
  }
}
