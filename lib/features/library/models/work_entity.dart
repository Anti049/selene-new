import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:selene/models/author_model.dart';
import 'package:selene/models/chapter_model.dart';
import 'package:selene/models/tag_model.dart';
import 'package:selene/models/work_model.dart';

part 'work_entity.freezed.dart';

@freezed
abstract class WorkEntity with _$WorkEntity {
  const factory WorkEntity({
    required WorkModel work,
    required List<AuthorModel> authors,
    required List<TagModel> tags,
    required List<ChapterModel> chapters,
  }) = _WorkEntity;
}
