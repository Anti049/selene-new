import 'dart:collection';

import 'package:isar/isar.dart';
import 'package:selene/core/database/mappers/author_mapper.dart';
import 'package:selene/core/database/mappers/chapter_mapper.dart';
import 'package:selene/core/database/mappers/series_mapper.dart';
import 'package:selene/core/database/mappers/tag_mapper.dart';
import 'package:selene/core/database/mappers/work_mapper.dart';
import 'package:selene/core/database/models/author.dart';
import 'package:selene/core/database/models/chapter.dart';
import 'package:selene/core/database/models/series.dart';
import 'package:selene/core/database/models/tag.dart';
import 'package:selene/core/database/models/work.dart';
import 'package:selene/core/database/tables/authors_table.dart';
import 'package:selene/core/database/tables/chapters_table.dart';
import 'package:selene/core/database/tables/series_table.dart';
import 'package:selene/core/database/tables/tags_table.dart';
import 'package:selene/core/database/tables/works_table.dart';

class WorkRepository {
  final Isar _isar;

  WorkRepository(this._isar);

  // --- Read Operations ---
  /// Watch all raw [Works] from the [_isar] database
  ///
  /// Returns a stream of [WorkModel]
  Stream<List<Work>> watchAllWorksRaw() {
    // Watch all works from the database
    return _isar.works.where().watch(fireImmediately: true);
  }

  /// Watch all [Works] from the [_isar] database
  ///
  /// Returns a stream of [WorkModel]
  Stream<List<WorkModel>> watchAllWorks() {
    // Watch all works from the database
    return _isar.works
        .where()
        .watch(fireImmediately: true)
        .asyncMap(
          (table) => Future.wait(table.map(WorkMapper.mapToModel).toList()),
        );
  }

  /// Get all [Works] from the [_isar] database
  ///
  /// Returns a list of [WorkModel]
  Future<List<WorkModel>> getAllWorks() async {
    // Get all works from the database
    final worksTable = await _isar.works.where().findAll();

    // Map the works to WorkModel and return
    return Future.wait(worksTable.map(WorkMapper.mapToModel).toList());
  }

  /// Get a [Work] by its [id] from the [_isar] database
  ///
  /// Returns null if the work is not found
  Future<WorkModel?> getWorkById(int id) async {
    // Get the work from the database
    final workEntity = await _isar.works.get(id);

    // If the work is not found, return null
    if (workEntity == null) return null;

    // Map entity to model and return
    return WorkMapper.mapToModel(workEntity);
  }

  /// Get a [Work] by its [sourceURL] from the [_isar] database
  ///
  /// Returns null if the work is not found
  Future<WorkModel?> getWorkBySourceURL(String sourceURL) async {
    // Get the work from the database
    final workEntity =
        await _isar.works.filter().sourceURLEqualTo(sourceURL).findFirst();

    // If the work is not found, return null
    if (workEntity == null) return null;

    // Map entity to model and return
    return WorkMapper.mapToModel(workEntity);
  }

  // --- Write Operations ---
  /// Upsert a [Work] to the [_isar] database
  ///
  /// Returns the [Work] that was upserted
  Future<WorkModel> upsertWork(WorkModel workModel) async {
    // Map WorkModel to Work table object
    final workEntity = WorkMapper.mapToTable(workModel);
    int workID = -1;

    // Upsert the work to the database/Perform database operations within a transaction
    await _isar.writeTxn(() async {
      // Handle author(s)
      final authorEntities = <Author>[];
      for (var authorModel in workModel.authors) {
        authorEntities.add(await _findOrCreateAuthor(authorModel));
      }

      // Handle series
      final seriesEntities = <Series>[];
      for (var seriesModel in workModel.series) {
        seriesEntities.add(await _findOrCreateSeries(seriesModel));
      }

      // Handle tags
      final tagEntities = <Tag>[];
      for (var tagModel in workModel.tags) {
        tagEntities.add(await _findOrCreateTag(tagModel));
      }

      // Handle chapters
      final chapterEntities = <Chapter>[];
      for (var chapterModel in workModel.chapters) {
        final chapterEntity = await _findOrCreateChapter(chapterModel);
        await _isar.chapters.put(chapterEntity);
        chapterEntities.add(chapterEntity);
      }

      // Save the work entity to the database
      workID = await _isar.works.put(workEntity);

      // Link the authors, series, tags, and chapters to the work
      // - Authors
      workEntity.authors.clear();
      workEntity.authors.addAll(authorEntities);
      await workEntity.authors.save();
      // - Series
      workEntity.series.clear();
      workEntity.series.addAll(seriesEntities);
      await workEntity.series.save();
      // - Tags
      workEntity.tags.clear();
      workEntity.tags.addAll(tagEntities);
      await workEntity.tags.save();
      // - Chapters
      workEntity.chapters.clear();
      workEntity.chapters.addAll(chapterEntities);
      await workEntity.chapters.save();
    });

    // Return the upserted work
    final savedEntity = await _isar.works.get(workID);
    return WorkMapper.mapToModel(savedEntity!);
  }

  /// Delete a [Work] by its [id] from the [_isar] database
  ///
  /// Returns true if the work was deleted, false otherwise
  Future<bool> deleteWorkById(int id) async {
    // Delete the work from the database
    bool wasWorkDeleted = false;
    // ALL chapters will be deleted
    // Tags, authors, and series will ONLY be deleted if not linked to any other works
    await _isar.writeTxn(() async {
      // Does work exist?
      final workToDelete = await _isar.works.get(id);
      if (workToDelete == null) return;

      // Get all linked entities
      // - Authors
      await workToDelete.authors.load();
      final authorIDs = workToDelete.authors.map((e) => e.id).toSet();
      // - Series
      await workToDelete.series.load();
      final seriesIDs = workToDelete.series.map((e) => e.id).toSet();
      // - Tags
      await workToDelete.tags.load();
      final tagIDs = workToDelete.tags.map((e) => e.id).toSet();
      // - Chapters
      await workToDelete.chapters.load();
      final chapterIDs = await _isar.chapters
          .filter()
          .work((q) => q.idEqualTo(id))
          .build()
          .findAll()
          .then((chapters) => chapters.map((e) => e.id).toList());
      if (chapterIDs.isEmpty) return;

      // Delete the work
      wasWorkDeleted = await _isar.works.delete(id);
      if (!wasWorkDeleted) return;

      // Delete all chapters linked to the work
      await _isar.chapters.deleteAll(chapterIDs);
      // Delete orphaned objects
      // - Authors
      for (final authorID in authorIDs) {
        final author = await _isar.authors.get(authorID);
        if (author != null) {
          await author.works.load();
          if (author.works.isEmpty) {
            await _isar.authors.delete(authorID);
          }
        }
      }
      // - Series
      for (final seriesID in seriesIDs) {
        final series = await _isar.series.get(seriesID);
        if (series != null) {
          await series.works.load();
          if (series.works.isEmpty) {
            await _isar.series.delete(seriesID);
          }
        }
      }
      // - Tags
      for (final tagID in tagIDs) {
        await _deleteTagsRecursively(tagID, HashSet<int>());
      }
    });
    // Return true if the work was deleted, false otherwise
    return wasWorkDeleted;
  }

  Future<bool> deleteWorksByIds(List<int> ids) async {
    // Delete multiple works by their IDs
    bool allDeleted = true;
    for (final id in ids) {
      final wasDeleted = await deleteWorkById(id);
      if (!wasDeleted) allDeleted = false;
    }
    return allDeleted;
  }

  // --- Helper Methods ---
  /// Find or create an author in the [_isar] database
  ///
  /// Returns the [Author] that was found or created
  Future<Author> _findOrCreateAuthor(AuthorModel authorModel) async {
    Author? authorEntity;
    if (authorModel.id != null) {
      authorEntity = await _isar.authors.get(authorModel.id!);
    }
    // Try finding by unique property if not found by ID or no ID given
    // (Assuming Author has a unique 'sourceURL' or 'name')
    if (authorEntity == null && authorModel.sourceURL != null) {
      authorEntity =
          await _isar.authors
              .filter()
              .sourceURLEqualTo(authorModel.sourceURL)
              .findFirst();
    }
    // If still not found, create and save a new one
    if (authorEntity == null) {
      authorEntity = AuthorMapper.mapToTable(authorModel);
      // Save the new entity to assign an ID
      await _isar.authors.put(authorEntity);
    } else {
      // Optionally: Update existing entity if model has newer data?
      // authorEntity = AuthorMapper.updateEntityFromModel(authorEntity, model);
      // await _isar.authors.put(authorEntity);
    }
    return authorEntity;
  }

  /// Delete Tags recursively
  ///
  /// Will recursively delete all Tags that are orphaned by a Work deletion
  Future<void> _deleteTagsRecursively(
    int tagID,
    HashSet<int> processedTagIDs,
  ) async {
    // Prevent infinite loops
    if (processedTagIDs.contains(tagID)) return;
    processedTagIDs.add(tagID);

    // Get the tag by its ID
    final tag = await _isar.tags.get(tagID);
    if (tag == null) return;

    // Load backlinks
    await tag.works.load();
    await tag.relatedByTags.load();

    // Check if orphaned
    final isOrphaned = tag.works.isEmpty && tag.relatedByTags.isEmpty;

    // Recursively delete related tags
    if (isOrphaned) {
      // BEFORE deleting, find IDs of tags THIS tag was related TO
      // We need to check these potentially orphaned tags after deleting this tag
      await tag.relatedTags.load();
      final formerlyRelatedIDs = tag.relatedTags.map((e) => e.id).toList();

      // Delete the tag
      await _isar.tags.delete(tagID);

      // Recursively delete related tags
      for (final relatedTag in formerlyRelatedIDs) {
        await _deleteTagsRecursively(relatedTag, processedTagIDs);
      }
    }
  }

  /// Find or create a tag in the [_isar] database
  ///
  /// Returns the [Tag] that was found or created
  Future<Tag> _findOrCreateTag(TagModel model) async {
    Tag? entity;
    if (model.id != null) {
      entity = await _isar.tags.get(model.id!);
    }
    entity ??=
        await _isar.tags
            .filter()
            .nameEqualTo(model.name, caseSensitive: false)
            .findFirst();
    if (entity == null) {
      entity = TagMapper.mapToTable(model);
      await _isar.tags.put(entity);
      // Handle saving tag relations if Tag can link to other Tags
      for (final relatedTag in model.relatedTags) {
        final relatedTagEntity = await _findOrCreateTag(relatedTag);
        entity.relatedTags.add(relatedTagEntity);
      }
      await entity.relatedTags.save();
    }
    return entity;
  }

  /// Find or create a series in the [_isar] database
  ///
  /// Returns the [Series] that was found or created
  Future<Series> _findOrCreateSeries(SeriesModel model) async {
    Series? entity;
    if (model.id != null) {
      entity = await _isar.series.get(model.id!);
    }
    // Add unique property lookup if applicable (e.g., series name or URL)
    if (entity == null && model.sourceURL != null) {
      entity =
          await _isar.series
              .filter()
              .sourceURLEqualTo(model.sourceURL)
              .findFirst();
    }
    if (entity == null) {
      entity = SeriesMapper.mapToTable(model);
      await _isar.series.put(entity);
    }
    return entity;
  }

  /// Find or create a chapter in the [_isar] database
  ///
  /// Returns the [Chapter] that was found or created
  Future<Chapter> _findOrCreateChapter(ChapterModel model) async {
    Chapter? entity;
    if (model.id != null) {
      entity = await _isar.chapters.get(model.id!);
    }
    // Add unique property lookup if applicable (e.g., chapter name or URL)
    if (entity == null && model.sourceURL != null) {
      entity =
          await _isar.chapters
              .filter()
              .sourceURLEqualTo(model.sourceURL)
              .findFirst();
    }
    if (entity == null) {
      entity = ChapterMapper.mapToTable(model);
      await _isar.chapters.put(entity);
    }
    return entity;
  }
}
