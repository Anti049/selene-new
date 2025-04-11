import 'package:isar/isar.dart';
import 'package:selene/core/database/models/tag.dart';
import 'package:selene/core/database/tables/works_table.dart';

part 'tags_table.g.dart';

@collection
@Name('Tags')
class Tag {
  Id id = Isar.autoIncrement;

  @Index(unique: true, caseSensitive: false)
  late String name;
  String? sourceURL;
  @enumerated
  late TagType type;
  @Backlink(to: 'tags')
  final works = IsarLinks<Work>();
  @Index()
  final relatedTags = IsarLinks<Tag>();
  @Backlink(to: 'relatedTags')
  final relatedByTags = IsarLinks<Tag>();

  Tag({required this.name, this.sourceURL, this.type = TagType.other});
}
