import 'package:isar/isar.dart';
import 'package:selene/core/database/tables/works_table.dart';

part 'fandoms_table.g.dart';

@collection
@Name('Fandoms')
class Fandom {
  Id id = Isar.autoIncrement;

  @Index()
  late String name;

  List<String>? sourceURLs;

  @Backlink(to: 'fandoms')
  final works = IsarLinks<Work>();

  List<String>? aliases = [];

  Fandom({required this.name, this.sourceURLs, this.aliases = const []});
}
