import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:selene/core/database/database.dart';
import 'package:selene/models/work_model.dart';

part 'tag_model.freezed.dart';
part 'tag_model.g.dart';

enum TagType {
  info,
  fandom,
  character,
  friendship,
  relationship,
  freeform,
  other,
}

@Freezed(makeCollectionsUnmodifiable: false)
abstract class TagModel with _$TagModel {
  const factory TagModel({
    required int id,
    required String sourceURL,
    required String label,
    @Default(TagType.info) TagType type,
    @Default([]) List<WorkModel> worksWithTag,
    @Default([]) List<TagModel> relatedTags,
  }) = _TagModel;

  factory TagModel.fromJson(Map<String, dynamic> json) =>
      _$TagModelFromJson(json);

  factory TagModel.fromData(Tag data) {
    return TagModel(
      id: data.id,
      sourceURL: data.sourceURL,
      label: data.label,
      type: data.type,
      worksWithTag: [],
      relatedTags: [],
    );
  }
}
