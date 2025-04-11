import 'package:selene/core/database/models/author.dart';
import 'package:selene/core/database/tables/authors_table.dart';

class AuthorMapper {
  /// Converts an [Author] table object to an [AuthorModel].
  ///
  /// This method MUST be called after the entity has been retrieved from Isar.
  /// It loads the related entities (works, bookmarks) and maps
  /// them to their respective models.
  static Future<AuthorModel> mapToModel(Author author) async {
    // Construct the AuthorModel
    return AuthorModel(
      id: author.id,
      name: author.name,
      sourceURL: author.sourceURL,
    );
  }

  /// Converts an [AuthorModel] to an [Author] table object.
  ///
  /// IMPORTANT: This method ONLY maps the direct fields. Establishing and
  /// saving the relationships (IsarLinks for works and bookmarks) MUST be
  /// handled separately within the repository's write transaction logic,
  /// AFTER the related entities have been found/created and saved in Isar.
  static Author mapToTable(AuthorModel authorModel) {
    // Create a new Author table object
    // Note: The id is set to null here. It will be set by Isar when the entity is saved.
    final authorEntity = Author(
      name: authorModel.name,
      sourceURL: authorModel.sourceURL,
    );

    // If the model has an id, set it on the entity
    // This is important for updating existing entities
    if (authorModel.id != null) {
      authorEntity.id = authorModel.id!;
    }

    // Note: Relationships (IsarLinks) are not set here. They should be handled
    // separately in the repository's write transaction logic.
    return authorEntity;
  }
}
