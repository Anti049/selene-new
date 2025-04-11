import 'package:selene/core/database/models/tag.dart';
import 'package:selene/core/database/tables/tags_table.dart';

class TagMapper {
  /// Converts a [Tag] table object to a [TagModel].
  ///
  /// This method MUST be called after the entity has been retrieved from Isar.
  /// It loads the related entities (works) and maps
  /// them to their respective models.
  static Future<TagModel> mapToModel(Tag tag) async {
    // Load related entities concurrently for efficiency
    await Future.wait([tag.relatedTags.load()]);

    // Map the loaded entities to their respective models
    final relatedTagsFuture = Future.wait(
      tag.relatedTags.map((relatedTag) => mapToModel(relatedTag)),
    );

    // Wait for all futures to complete
    final relatedTags = await relatedTagsFuture;

    // Construct the TagModel
    return TagModel(
      id: tag.id,
      name: tag.name,
      sourceURL: tag.sourceURL,
      type: tag.type,
      relatedTags: relatedTags,
    );
  }

  /// Converts a [TagModel] to a [Tag] table object.
  ///
  /// IMPORTANT: This method ONLY maps the direct fields. Establishing and
  /// loading relationships must be handled separately.
  static Tag mapToTable(TagModel tagModel) {
    // Create a new Work table object
    // Note: The id is set to null here. It will be set by Isar when the entity is saved.
    final tagEntity = Tag(
      name: tagModel.name,
      sourceURL: tagModel.sourceURL,
      type: tagModel.type,
    );

    // If the model has an id, set it on the entity
    // This is important for updating existing entities
    if (tagModel.id != null) {
      tagEntity.id = tagModel.id!;
    }

    // Note: Relationships (IsarLinks) are not set here. They should be handled
    // separately in the repository's write transaction logic.
    return tagEntity;
  }
}
