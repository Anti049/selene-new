import 'package:isar/isar.dart';
import 'package:selene/core/database/tables/works_table.dart';

part 'fandoms_table.g.dart';

@collection
@Name('Fandoms')
class Fandom {
  Id id = Isar.autoIncrement;

  @Index()
  late String name;

  @Index(unique: true, caseSensitive: false)
  String? sourceURL;

  @Backlink(to: 'fandoms')
  final works = IsarLinks<Work>();

  List<String>? aliases = [];

  Fandom({required this.name, this.sourceURL, this.aliases = const []});
}
