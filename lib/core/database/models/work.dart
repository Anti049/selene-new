import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:selene/core/database/models/author.dart';
import 'package:selene/core/database/models/chapter.dart';
import 'package:selene/core/database/models/series.dart';
import 'package:selene/core/database/models/tag.dart';

part 'work.freezed.dart';

enum WorkStatus {
  unknown('Unknown'),
  completed('Completed'),
  inProgress('In-Progress'),
  abandoned('Abandoned'),
  onHiatus('On Hiatus');

  const WorkStatus(this.label);

  final String label;
}

@Freezed(makeCollectionsUnmodifiable: false)
class WorkModel with _$WorkModel {
  const WorkModel._();

  const factory WorkModel({
    int? id,
    required String title,
    String? sourceURL,
    String? summary,
    int? wordCount,
    @Default(WorkStatus.unknown) WorkStatus status,
    String? coverURL,
    DateTime? datePublished,
    DateTime? dateUpdated,
    @Default([]) List<AuthorModel> authors,
    @Default([]) List<SeriesModel> series,
    @Default([]) List<TagModel> tags,
    @Default([]) List<ChapterModel> chapters,
  }) = _WorkModel;

  factory WorkModel.generateRandomWork() {
    final random = Random();

    final title = 'Work ${random.nextInt(100)}';
    final sourceURL = 'https://example.com/work/${random.nextInt(100)}';
    final summary = 'This is a summary of the work.';
    final wordCount = random.nextInt(1000);
    final status = WorkStatus.values[random.nextInt(WorkStatus.values.length)];
    final coverURL = 'https://example.com/cover/${random.nextInt(100)}.jpg';
    final datePublished = DateTime.now().subtract(
      Duration(days: random.nextInt(365)),
    );
    final dateUpdated = DateTime.now().subtract(
      Duration(days: random.nextInt(365)),
    );
    final authors = List.generate(
      random.nextInt(3) + 1,
      (_) => AuthorModel(
        name: 'Author ${random.nextInt(100)}',
        sourceURL: 'https://example.com/author/${random.nextInt(100)}',
      ),
    );
    final series = List.generate(
      random.nextInt(2),
      (_) => SeriesModel(
        title: 'Series ${random.nextInt(100)}',
        sourceURL: 'https://example.com/series/${random.nextInt(100)}',
      ),
    );
    final tags = List.generate(
      random.nextInt(10) + 1,
      (_) => TagModel(
        name: 'Tag ${random.nextInt(100)}',
        sourceURL: 'https://example.com/tag/${random.nextInt(100)}',
      ),
    );
    final chapters = List.generate(
      random.nextInt(41) + 10,
      (i) => ChapterModel(
        index: i,
        title: 'Chapter ${i + 1}',
        sourceURL: '$sourceURL/chapter/${i + 1}',
        wordCount: random.nextInt(1000),
        datePublished: DateTime.now().subtract(
          Duration(days: random.nextInt(365)),
        ),
      ),
    );

    return WorkModel(
      id: null,
      title: title,
      sourceURL: sourceURL,
      summary: summary,
      wordCount: wordCount,
      status: status,
      coverURL: coverURL,
      datePublished: datePublished,
      dateUpdated: dateUpdated,
      authors: authors,
      series: series,
      tags: tags,
      chapters: chapters,
    );
  }
}
