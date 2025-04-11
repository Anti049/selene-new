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
}
