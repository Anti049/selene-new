import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:selene/core/database/providers/isar_provider.dart';
import 'package:selene/core/logging/logger_provider.dart';
import 'package:selene/data/local/file_service_registry.dart';
import 'package:selene/data/repositories/chapters_repository.dart';
import 'package:selene/data/repositories/works_repository.dart';
import 'package:selene/features/settings/screens/data_storage/providers/data_storage_preferences.dart';

part 'library_providers.g.dart';

@Riverpod(keepAlive: true)
WorksRepository worksRepository(Ref ref) {
  // Get dependencies
  final isar = ref.read(isarProvider).requireValue;
  final dataStoragePrefs = ref.read(dataStoragePreferencesProvider);
  final fileServiceRegistry = ref.read(fileServiceRegistryProvider);
  final logger = ref.read(loggerProvider);

  // Create repository
  final repo = WorksRepository(
    isar,
    dataStoragePrefs,
    fileServiceRegistry,
    logger,
  );

  // Dispose of the repository when the provider is disposed
  ref.onDispose(() {
    repo.dispose();
    logger.d('WorksRepository disposed');
  });

  // Return the repository
  return repo;
}

// @riverpod
// AuthorRepository authorRepository(Ref ref) {
//   return AuthorRepository(ref.read(isarProvider).value!);
// }

// @riverpod
// SeriesRepository chapterRepository(Ref ref) {
//   return SeriesRepository(ref.read(isarProvider).value!);
// }

// @riverpod
// TagRepository chapterRepository(Ref ref) {
//   return TagRepository(ref.read(isarProvider).value!);
// }

@riverpod
ChapterRepository chapterRepository(Ref ref) {
  final isar = ref.watch(isarProvider).requireValue;
  return ChapterRepository(isar);
}
