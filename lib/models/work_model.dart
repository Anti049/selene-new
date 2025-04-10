import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:selene/models/author_model.dart';
import 'package:selene/models/chapter_model.dart';
import 'package:selene/models/tag_model.dart';

part 'work_model.freezed.dart';
part 'work_model.g.dart';

enum WorkStatus {
  unknown('Unknown'),
  inProgress('In Progress'),
  complete('Complete'),
  abandoned('Abandoned'),
  onHiatus('On Hiatus'),
  beingRewritten('Being Rewritten');

  const WorkStatus(this.label);

  final String label;
}

@Freezed(makeCollectionsUnmodifiable: false)
abstract class WorkModel with _$WorkModel {
  const factory WorkModel({
    required int id,
    required String sourceURL,
    required String title,
    @Default([]) List<AuthorModel> authors,
    String? summary,
    @Default(WorkStatus.unknown) WorkStatus status,
    @Default(0) int wordCount,
    @Default([]) List<ChapterModel> chapters,
    @Default([]) List<TagModel> tags,
  }) = _WorkModel;

  factory WorkModel.fromJson(Map<String, dynamic> json) =>
      _$WorkModelFromJson(json);
}
