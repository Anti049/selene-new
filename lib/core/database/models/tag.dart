import 'package:freezed_annotation/freezed_annotation.dart';

part 'tag.freezed.dart';

enum TagType {
  info,
  fandom,
  character,
  friendship,
  romance,
  freeform,
  other;

  static const Map<TagType, String> _names = {
    TagType.info: 'Info',
    TagType.fandom: 'Fandom',
    TagType.character: 'Character',
    TagType.friendship: 'Friendship',
    TagType.romance: 'Romance',
    TagType.freeform: 'Freeform',
    TagType.other: 'Other',
  };

  static TagType fromString(String name) {
    return _names.entries
        .firstWhere(
          (entry) => entry.value.toLowerCase() == name.toLowerCase(),
          orElse: () => const MapEntry(TagType.other, ''),
        )
        .key;
  }
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
