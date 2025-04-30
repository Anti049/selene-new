import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:isar/isar.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart' as p;
import 'package:rxdart/rxdart.dart';
import 'package:selene/core/database/mappers/author_mapper.dart';
import 'package:selene/core/database/mappers/chapter_mapper.dart';
import 'package:selene/core/database/mappers/fandom_mapper.dart';
import 'package:selene/core/database/mappers/series_mapper.dart';
import 'package:selene/core/database/mappers/tag_mapper.dart';
import 'package:selene/core/database/mappers/work_mapper.dart';
import 'package:selene/core/database/models/author.dart';
import 'package:selene/core/database/models/chapter.dart';
import 'package:selene/core/database/models/fandom.dart';
import 'package:selene/core/database/models/series.dart';
import 'package:selene/core/database/models/tag.dart';
import 'package:selene/core/database/models/work.dart';
import 'package:selene/core/database/tables/authors_table.dart';
import 'package:selene/core/database/tables/chapters_table.dart';
import 'package:selene/core/database/tables/fandoms_table.dart';
import 'package:selene/core/database/tables/series_table.dart';
import 'package:selene/core/database/tables/tags_table.dart';
import 'package:selene/core/database/tables/works_table.dart';
import 'package:selene/data/local/file_service_registry.dart';
import 'package:selene/features/settings/screens/data_storage/providers/data_storage_preferences.dart';
import 'package:watcher/watcher.dart';

class WorksRepository {
  // Dependencies
  final Isar _isar;
  final DataStoragePreferences _dataStoragePrefs;
  final FileServiceRegistry _fileServiceRegistry;
  final Logger _logger;
  // Stream utilities
  StreamSubscription? _directoryWatcherSubscription;
  StreamSubscription? _preferencesSubscription;
  final _fileSystemChangeController = StreamController<void>.broadcast();

  WorksRepository(
    this._isar,
    this._dataStoragePrefs,
    this._fileServiceRegistry,
    this._logger,
  ) {
    // Initialize directory watcher for the library folder
    _initDirectoryWatcher();
    // Listen to data storage preferences changes
    _preferencesSubscription = _dataStoragePrefs.libraryFolder.stream.listen((
      _,
    ) {
      // Reinitialize directory watcher if the library folder changes
      _initDirectoryWatcher();
    });
  }

  // Dispose method to clean up resources
  void dispose() {
    // Cancel directory watcher subscription if it exists
    _directoryWatcherSubscription?.cancel();
    // Cancel preferences subscription if it exists
    _preferencesSubscription?.cancel();
    // Close the file system change controller
    _fileSystemChangeController.close();
  }

  // Sync the library on startup
  Future<void> syncLibraryOnStartup() async {
    _logger.i('Syncing library on startup...');

    // Get the library folder from preferences
    final libraryFolder = _dataStoragePrefs.libraryFolder.get();
    if (libraryFolder.isEmpty) {
      _logger.w('Library folder is not set. Skipping library sync.');
      return;
    }
    if (!Directory(libraryFolder).existsSync()) {
      _logger.w(
        'Library folder does not exist: $libraryFolder. Skipping library sync.',
      );
      return;
    }
    _logger.i('Syncing library from folder: $libraryFolder');

    // Get all files in the library folder
    final directory = Directory(libraryFolder);
    final files = directory.listSync(recursive: true, followLinks: false);

    // Process each file
    for (final file in files) {
      if (file is File &&
          _fileServiceRegistry.allAcceptedExtensions.contains(
            p.extension(file.path).toLowerCase(),
          )) {
        await _handleFileAdd(file.path);
      }
    }
  }

  // Initialize directory watcher for the library folder
  void _initDirectoryWatcher() {
    // Cancel existing subscription if it exists
    _directoryWatcherSubscription?.cancel();
    _directoryWatcherSubscription = null;

    // Validate library folder
    final libraryFolder = _dataStoragePrefs.libraryFolder.get();
    if (libraryFolder.isEmpty) {
      _logger.w(
        'Library folder is not set. Skipping directory watcher initialization.',
      );
      return;
    }
    if (!Directory(libraryFolder).existsSync()) {
      _logger.w(
        'Library folder does not exist: $libraryFolder. Skipping directory watcher initialization.',
      );
      return;
    }
    _logger.i(
      'Initializing directory watcher for library folder: $libraryFolder',
    );

    try {
      // Watch for create/delete/move events in the library folder
      final watcher = DirectoryWatcher(libraryFolder);
      _directoryWatcherSubscription = watcher.events.listen((event) {
        // Log the event
        _logger.i('File system event: ${event.type} at ${event.path}');

        // Normalize the path to handle different OS path formats
        final normalizedPath = p.normalize(event.path);
        final extension = p.extension(normalizedPath).toLowerCase();

        // Filter for EPUB files and relevant events
        if (_fileServiceRegistry.allAcceptedExtensions.contains(extension)) {
          switch (event.type) {
            case ChangeType.ADD:
              _logger.i('EPUB file added: $normalizedPath');
              // Handle new EPUB file addition
              _handleFileAdd(normalizedPath);
              break;
            case ChangeType.REMOVE:
              _logger.i('EPUB file removed: $normalizedPath');
              // Handle EPUB file removal
              _handleFileDelete(normalizedPath);
              break;
            case ChangeType.MODIFY:
              _logger.i('EPUB file modified: $normalizedPath');
              // Handle EPUB file modification
              _handleFileChange(normalizedPath);
              break;
          }
        }
      });
    } catch (e) {
      _logger.e('Failed to initialize directory watcher: $e');
      // Restart after 15-second delay
      _logger.i('Retrying directory watcher initialization in 15 seconds...');
      _directoryWatcherSubscription?.cancel();
      _directoryWatcherSubscription = null;
      Future.delayed(const Duration(seconds: 15), _initDirectoryWatcher);
    }
  }

  Future<void> _handleFileAdd(String filePath) async {
    // Find appropriate service
    final fileService = _fileServiceRegistry.getServiceByExtension(
      p.extension(filePath).toLowerCase(),
    );
    if (fileService == null) {
      _logger.w('No file service found for file: $filePath');
      return;
    }

    try {
      // Check if work already exists by filePath
      final existingWork =
          await _isar.works.filter().filePathEqualTo(filePath).findFirst();
      if (existingWork != null) {
        _logger.w('Work already exists for file: $filePath');
        // TODO: Update work metadata if file modification timestamp is newer
        return;
      }

      // Load the work from the file using the file service
      _logger.i('Adding new work from file: $filePath');
      final workModel = await fileService.loadFile(filePath);
      if (workModel == null) {
        _logger.w('Failed to load work from file: $filePath');
        return;
      }

      // Upsert the work to the database
      _logger.i('Loaded work from file: $filePath, upserting to database...');
      final savedWork = await upsertWork(workModel);
      _fileSystemChangeController.add(null);
      _logger.i(
        'Work upserted successfully: ${savedWork.id} - ${savedWork.title}',
      );
    } catch (e) {
      _logger.e('Failed to handle file add for $filePath: $e');
      return;
    }
  }

  Future<void> _handleFileDelete(String filePath) async {
    try {
      // Find work by filePath
      final workToDelete =
          await _isar.works.filter().filePathEqualTo(filePath).findFirst();

      if (workToDelete == null) {
        _logger.w('No work found for file: $filePath');
        return;
      }

      // Delete the work by ID
      // TODO: Add to "Deleted Works" table for recovery
      _logger.i('Deleting work for file: $filePath, ID: ${workToDelete.id}');
      final wasDeleted = await deleteWorkByID(workToDelete.id);
      if (!wasDeleted) {
        _logger.w('Failed to delete work for file: $filePath');
        return;
      }
      _logger.i('Work deleted successfully for file: $filePath');
      _fileSystemChangeController.add(null);
    } catch (e) {
      _logger.e('Failed to handle file delete for $filePath: $e');
      return;
    }
  }

  Future<void> _handleFileChange(String filePath) async {
    // Find the appropriate service
    final fileService = _fileServiceRegistry.getServiceByExtension(
      p.extension(filePath).toLowerCase(),
    );
    if (fileService == null) {
      _logger.w('No file service found for file: $filePath');
      return;
    }
    try {
      // Find work by filePath
      final workToUpdate =
          await _isar.works.filter().filePathEqualTo(filePath).findFirst();
      if (workToUpdate == null) {
        _logger.w('No work found for file: $filePath');
        return;
      }

      // Load the work from the file using the file service
      _logger.i('Updating work from file: $filePath');
      final workModel = await fileService.loadFile(filePath);
      if (workModel == null) {
        _logger.w('Failed to load work from file: $filePath');
        return;
      }
      // Upsert the work to the database
      _logger.i('Loaded work from file: $filePath, upserting to database...');
      final updatedWork = workModel.copyWith(
        id: workToUpdate.id,
        filePath: filePath,
        readProgress: workToUpdate.readProgress,
      );
      final savedWork = await upsertWork(updatedWork);
      _fileSystemChangeController.add(null);
      _logger.i(
        'Work updated successfully: ${savedWork.id} - ${savedWork.title}',
      );
    } catch (e) {
      _logger.e('Failed to handle file change for $filePath: $e');
      return;
    }
  }

  // --- Read Operations ---
  /// Watch all raw [Works] from the [_isar] database
  ///
  /// Returns a stream of [WorkModel]
  Stream<List<Work>> watchAllWorksRaw() {
    // Get streams
    final isarStream = _isar.works.where().watch(fireImmediately: true);
    final fileSystemStream = _fileSystemChangeController.stream;

    // Combine streams to watch all works from the database and file system changes
    return Rx.combineLatest2(
      isarStream,
      fileSystemStream.startWith(null),
      (isarList, _) => isarList,
    ).distinct((prev, next) => prev == next);
  }

  /// Watch all [Works] from the [_isar] database
  ///
  /// Returns a stream of [WorkModel]
  Stream<List<WorkModel>> watchAllWorks() {
    return watchAllWorksRaw().asyncMap((worksTable) async {
      try {
        return await _isar.txn(() async {
          return await Future.wait(
            worksTable.map(WorkMapper.mapToModel).toList(),
          );
        });
      } catch (e) {
        _logger.e('Error in watchAllWorks: $e');
        return []; // Return an empty list on error
      }
    });
  }

  /// Get all [Works] from the [_isar] database
  ///
  /// Returns a list of [WorkModel]
  Future<List<WorkModel>> getAllWorks() async {
    final worksTable = await _isar.works.where().findAll();
    // Use transaction for potentially complex mapping
    return await _isar.txn(() async {
      return await Future.wait(worksTable.map(WorkMapper.mapToModel).toList());
    });
  }

  /// Get a [Work] by its [id] from the [_isar] database
  ///
  /// Returns null if the work is not found
  Future<WorkModel?> getWorkByID(int id) async {
    final workEntity = await _isar.works.get(id);
    if (workEntity == null) return null;
    // Use transaction for potentially complex mapping
    return await _isar.txn(() => WorkMapper.mapToModel(workEntity));
  }

  /// Get a [Work] by its [sourceURL] from the [_isar] database
  ///
  /// Returns null if the work is not found
  Future<WorkModel?> getWorkBySourceURL(String sourceURL) async {
    final workEntity =
        await _isar.works
            .filter()
            .sourceURLEqualTo(sourceURL, caseSensitive: false)
            .findFirst();
    if (workEntity == null) return null;
    // Use transaction for potentially complex mapping
    return await _isar.txn(() => WorkMapper.mapToModel(workEntity));
  }

  // --- Write Operations ---
  /// Upsert a [Work] to the [_isar] database
  ///
  /// Returns the [Work] that was upserted
  Future<WorkModel> upsertWork(WorkModel workModel) async {
    // Check if a work has the same filePath
    Work? existingWork;
    if (workModel.filePath != null) {
      existingWork =
          await _isar.works
              .filter()
              .filePathEqualTo(workModel.filePath!)
              .findFirst();
    }
    // If no filePath, check by sourceURL
    if (existingWork == null && workModel.sourceURL != null) {
      existingWork =
          await _isar.works
              .filter()
              .sourceURLEqualTo(workModel.sourceURL, caseSensitive: false)
              .findFirst();
    }
    // If no existing work found, check by ID
    if (existingWork == null && workModel.id != null) {
      existingWork = await _isar.works.get(workModel.id!);
    }

    // Map WorkModel to Work table object
    final workEntity = WorkMapper.mapToTable(workModel);
    if (existingWork != null) {
      // If a work with the same sourceURL exists, update the entity
      workEntity.id = existingWork.id;
      // Preserve read progress
      workEntity.readProgress =
          workModel.readProgress ?? existingWork.readProgress;
    }

    // Initialize workID
    int workID = Isar.autoIncrement;

    // Upsert the work to the database/Perform database operations within a transaction
    await _isar.writeTxn(() async {
      // Handle fandom(s)
      final fandomEntities = <Fandom>[];
      for (var fandomModel in workModel.fandoms) {
        fandomEntities.add(await _findOrCreateFandom(fandomModel));
      }

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

      // --- Update Links ---
      // Fetch the potentially updated work entity to ensure links are saved correctly
      final savedWorkEntity = await _isar.works.get(workID);
      if (savedWorkEntity == null) {
        // Should not happen in a successful transaction, but handle defensively
        throw Exception("Failed to retrieve saved work with ID: $workID");
      }

      // Link the fandom(s), author(s), series, tag(s), and chapter(s) to the work
      // - Fandoms
      savedWorkEntity.fandoms.clear();
      savedWorkEntity.fandoms.addAll(fandomEntities);
      await savedWorkEntity.fandoms.save();
      // - Authors
      savedWorkEntity.authors.clear();
      savedWorkEntity.authors.addAll(authorEntities);
      await savedWorkEntity.authors.save();
      // - Series
      savedWorkEntity.series.clear();
      savedWorkEntity.series.addAll(seriesEntities);
      await savedWorkEntity.series.save();
      // - Tags
      savedWorkEntity.tags.clear();
      savedWorkEntity.tags.addAll(tagEntities);
      await savedWorkEntity.tags.save();
      // - Chapters
      savedWorkEntity.chapters.clear();
      savedWorkEntity.chapters.addAll(chapterEntities);
      await savedWorkEntity.chapters.save();
      // Also update the backlink from chapters to the work
      for (final chapter in chapterEntities) {
        chapter.work.value = savedWorkEntity;
        await chapter.work.save();
      }
      _logger.d('Work upserted with ID: $workID');
    });

    // Return the upserted work
    final finalWorkEntity = await _isar.works.get(workID);
    if (finalWorkEntity == null) {
      _logger.e("Failed to fetch final work entity after upsert. ID: $workID");
      throw Exception("Upsert failed for work: ${workModel.title}");
    }
    // Use transaction for potentially complex mapping
    return await _isar.txn(() => WorkMapper.mapToModel(finalWorkEntity));
  }

  /// Updates a work's read progress
  Future<void> updateWorkProgress(int workID, {String? readProgress}) {
    return _isar.writeTxn(() async {
      final work = await _isar.works.get(workID);
      if (work == null) {
        throw Exception("Work with ID $workID not found");
      }
      bool changed = false;
      if (readProgress != null && work.readProgress != readProgress) {
        work.readProgress = readProgress;
        changed = true;
      }
      if (changed) {
        await _isar.works.put(work);
      }
    });
  }

  /// Delete a [Work] by its [id] from the [_isar] database
  ///
  /// Returns true if the work was deleted, false otherwise
  Future<bool> deleteWorkByID(int id) async {
    // Delete the work from the database
    bool wasWorkDeleted = false;
    // ALL chapters will be deleted
    // Tags, authors, and series will ONLY be deleted if not linked to any other works
    await _isar.writeTxn(() async {
      // Does work exist?
      final workToDelete = await _isar.works.get(id);
      if (workToDelete == null) return;

      // Get all linked entities
      // - Fandoms
      await workToDelete.fandoms.load();
      final fandomIDs = workToDelete.fandoms.map((e) => e.id).toSet();
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
      // - Fandoms
      for (final fandomID in fandomIDs) {
        final fandom = await _isar.fandoms.get(fandomID);
        if (fandom != null) {
          await fandom.works.load();
          if (fandom.works.isEmpty) {
            await _isar.fandoms.delete(fandomID);
          }
        }
      }
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

  Future<bool> deleteWorksByIDs(List<int> ids) async {
    // Delete multiple works by their IDs
    bool allDeleted = true;
    for (final id in ids) {
      final wasDeleted = await deleteWorkByID(id);
      if (!wasDeleted) allDeleted = false;
    }
    return allDeleted;
  }

  // --- Helper Methods ---
  /// Find or create a fandom in the [_isar] database
  ///
  /// Returns the [Fandom] that was found or created
  Future<Fandom> _findOrCreateFandom(FandomModel fandomModel) async {
    Fandom? fandomEntity;
    if (fandomModel.id != null) {
      fandomEntity = await _isar.fandoms.get(fandomModel.id!);
    }
    // Try finding by unique property if not found by ID or no ID given
    // (Assuming Fandom has a unique 'sourceURL' or 'name')
    fandomEntity ??=
        await _isar.fandoms
            .filter()
            .nameEqualTo(fandomModel.name, caseSensitive: false)
            .findFirst();
    // If still not found, create and save a new one
    if (fandomEntity == null) {
      fandomEntity = FandomMapper.mapToTable(fandomModel);
      // Save the new entity to assign an ID
      await _isar.fandoms.put(fandomEntity);
    } else {
      // Optionally: Update existing entity if model has newer data?
      // fandomEntity = FandomMapper.updateEntityFromModel(
      //   fandomEntity,
      //   fandomModel,
      // );
      // await _isar.fandoms.put(fandomEntity); // Not needed if only updating fields
    }
    return fandomEntity;
  }

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
