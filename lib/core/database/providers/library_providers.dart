import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:selene/core/database/providers/isar_provider.dart';
import 'package:selene/data/repositories/work_repository.dart';

part 'library_providers.g.dart';

@riverpod
WorkRepository workRepository(Ref ref) {
  return WorkRepository(ref.read(isarProvider).value!);
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

// @riverpod
// ChapterRepository chapterRepository(Ref ref) {
//   return ChapterRepository(ref.read(isarProvider).value!);
// }
