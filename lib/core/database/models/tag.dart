import 'package:freezed_annotation/freezed_annotation.dart';

part 'tag.freezed.dart';

enum TagType {
  info,
  fandom,
  character,
  friendship,
  relationship,
  freeform,
  other,
}

@freezed
class TagModel with _$TagModel {
  const TagModel._();

  const factory TagModel({
    int? id,
    required String name,
    String? sourceURL,
    @Default(TagType.other) TagType type,
    @Default([]) List<TagModel> relatedTags,
  }) = _TagModel;
}
