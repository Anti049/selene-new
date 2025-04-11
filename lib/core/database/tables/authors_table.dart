import 'package:isar/isar.dart';
import 'package:selene/core/database/tables/works_table.dart';

part 'authors_table.g.dart';

@Collection(ignore: {'copyWith'})
@Name('Authors')
class Author {
  Id id = Isar.autoIncrement;

  @Index()
  late String name;

  @Index(unique: true, caseSensitive: false)
  String? sourceURL;

  @Backlink(to: 'authors')
  final works = IsarLinks<Work>();

  final bookmarks = IsarLinks<Work>();

  Author({required this.name, this.sourceURL});
}
