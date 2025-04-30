import 'package:selene/core/database/models/fandom.dart';
import 'package:selene/core/database/tables/fandoms_table.dart';

class FandomMapper {
  /// Converts a [Fandom] table object to a [FandomModel].
  ///
  /// This method MUST be called after the entity has been retrieved from Isar.
  /// It loads the related works and maps them to their respective models.
  static Future<FandomModel> mapToModel(Fandom fandom) async {
    // Construct the FandomModel
    return FandomModel(
      id: fandom.id,
      name: fandom.name,
      sourceURLs: fandom.sourceURLs ?? [],
      aliases: fandom.aliases ?? [],
    );
  }

  /// Converts a [FandomModel] to a [Fandom] table object.
  ///
  /// IMPORTANT: This method ONLY maps the direct fields. Establishing and
  /// saving the relationships (IsarLinks for works) MUST be handled separately
  /// within the repository's write transaction logic,
  /// AFTER the related entities have been found/created and saved in Isar.
  static Fandom mapToTable(FandomModel fandomModel) {
    // Create a new Fandom table object
    // Note: The id is set to null here. It will be set by Isar when the entity is saved.
    final fandomEntity = Fandom(
      name: fandomModel.name,
      sourceURLs: fandomModel.sourceURLs,
      aliases: fandomModel.aliases,
    );

    // If the model has an id, set it on the entity
    // This is important for updating existing entities
    if (fandomModel.id != null) {
      fandomEntity.id = fandomModel.id!;
    }

    // Note: Relationships (IsarLinks) are not set here. They should be handled
    // separately in the repository's write transaction logic.
    return fandomEntity;
  }
}
