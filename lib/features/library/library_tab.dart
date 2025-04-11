import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:selene/common/widgets/empty.dart';
import 'package:selene/core/database/models/author.dart';
import 'package:selene/core/database/models/chapter.dart';
import 'package:selene/core/database/models/series.dart';
import 'package:selene/core/database/models/tag.dart';
import 'package:selene/core/database/models/work.dart';
import 'package:selene/core/database/providers/library_providers.dart';
import 'package:selene/core/utils/theming.dart';
import 'package:selene/features/settings/screens/appearance/providers/appearance_preferences.dart';

@RoutePage()
class LibraryTab extends ConsumerWidget {
  const LibraryTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appearancePrefs = ref.watch(appearancePreferencesProvider);
    final workRepository = ref.watch(workRepositoryProvider);

    return Scaffold(
      body: Empty(
        message: 'Library Not Implemented',
        subtitle: appearancePrefs.themeID.value,
      ),
      floatingActionButton: Column(
        spacing: 8.0,
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.small(
            foregroundColor: context.scheme.onSecondaryContainer,
            backgroundColor: context.scheme.secondaryContainer,
            splashColor: context.scheme.onSecondaryContainer.withValues(
              alpha: 0.1,
            ),
            child: const Icon(Symbols.remove),
            onPressed: () {
              workRepository.deleteWorkById(3);
            },
          ),
          FloatingActionButton(
            child: const Icon(Symbols.add),
            onPressed: () {
              // Generate some random authors
              final numAuthors = 3;
              final authors = List.generate(
                numAuthors,
                (index) => AuthorModel(
                  name: 'Author $index',
                  sourceURL: Random().nextDouble().toString(),
                ),
              );
              // Generate a random series
              final series = List.generate(
                numAuthors,
                (index) => SeriesModel(
                  title: 'Series $index',
                  sourceURL: Random().nextDouble().toString(),
                  summary: 'Summary $index',
                ),
              );
              // Generate some random tags
              final numTags = 10;
              final tags = List.generate(
                numTags,
                (index) => TagModel(
                  name: 'Tag $index +- 1',
                  sourceURL: Random().nextDouble().toString(),
                  relatedTags: [
                    TagModel(
                      name: 'Related Tag $index - 1',
                      sourceURL: Random().nextDouble().toString(),
                    ),
                    TagModel(
                      name: 'Related Tag $index + 1',
                      sourceURL: Random().nextDouble().toString(),
                    ),
                  ],
                ),
              );
              // Generate some random chapters
              final numChapters = Random().nextInt(10) + 1;
              final chapters = List.generate(
                numChapters,
                (index) => ChapterModel(
                  title: 'Chapter ${index + 1}',
                  sourceURL: Random().nextDouble().toString(),
                  index: index + 1,
                  wordCount: Random().nextInt(1000) + 1,
                  datePublished: DateTime.now().subtract(
                    Duration(days: Random().nextInt(365)),
                  ),
                  content: 'Content $index',
                ),
              );
              // Generate a work
              final work = WorkModel(
                title: 'Work Title',
                sourceURL: Random().nextDouble().toString(),
                authors: authors,
                series: series,
                tags: tags,
                chapters: chapters,
                wordCount: chapters.fold(
                  0,
                  (previousValue, chapter) =>
                      previousValue! + (chapter.wordCount ?? 0),
                ),
              );

              // Save the work to the database
              workRepository.upsertWork(work);
            },
          ),
        ],
      ),
    );
  }
}
