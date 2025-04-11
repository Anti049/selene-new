import 'package:selene/core/database/models/series.dart';
import 'package:selene/core/database/tables/series_table.dart';

class SeriesMapper {
  /// Converts a [Series] table object to a [SeriesModel].
  ///
  /// This method MUST be called after the entity has been retrieved from Isar.
  /// It loads the related entities (works) and maps them to their respective models.
  static Future<SeriesModel> mapToModel(Series series) async {
    // Construct the SeriesModel
    return SeriesModel(
      id: series.id,
      title: series.title,
      sourceURL: series.sourceURL,
      summary: series.summary,
      wordCount: series.wordCount,
      datePublished: series.datePublished,
      dateUpdated: series.dateUpdated,
    );
  }

  /// Converts a [SeriesModel] to a [Series] table object.
  ///
  /// IMPORTANT: This method ONLY maps the direct fields. Establishing and
  /// loading relationships must be handled separately.
  static Series mapToTable(SeriesModel seriesModel) {
    // Create a new Series table object
    // Note: The id is set to null here. It will be set by Isar when the entity is saved.
    final seriesEntity = Series(
      title: seriesModel.title,
      sourceURL: seriesModel.sourceURL,
      summary: seriesModel.summary,
      wordCount: seriesModel.wordCount,
      datePublished: seriesModel.datePublished,
      dateUpdated: seriesModel.dateUpdated,
    );

    // If the model has an id, set it on the entity
    // This is important for updating existing entities
    if (seriesModel.id != null) {
      seriesEntity.id = seriesModel.id!;
    }

    // Note: Relationships (IsarLinks) are not set here. They should be handled
    // separately in the repository's write transaction logic.
    return seriesEntity;
  }
}
