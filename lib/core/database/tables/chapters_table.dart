import 'package:isar/isar.dart';
import 'package:selene/core/database/tables/works_table.dart';

part 'chapters_table.g.dart';

@collection
@Name('Chapters')
class Chapter {
  Id id = Isar.autoIncrement;

  @Index()
  late String title;
  @Index()
  String? sourceURL;
  late int index;
  int? wordCount;
  DateTime? datePublished;
  late bool isRead;

  @Backlink(to: 'chapters')
  final work = IsarLink<Work>();

  Chapter({
    required this.title,
    this.sourceURL,
    required this.index,
    this.wordCount,
    this.datePublished,
    this.isRead = false,
  });
}
