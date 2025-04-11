import 'package:isar/isar.dart';
import 'package:selene/core/database/tables/authors_table.dart';
import 'package:selene/core/database/tables/works_table.dart';

part 'series_table.g.dart';

@collection
@Name('Series')
class Series {
  Id id = Isar.autoIncrement;

  @Index(unique: true, caseSensitive: false)
  late String title;
  String? sourceURL;
  String? summary;
  int? wordCount;
  DateTime? datePublished;
  DateTime? dateUpdated;
  @Backlink(to: 'series')
  final works = IsarLinks<Work>();
  @Index()
  final authors = IsarLinks<Author>();

  Series({
    required this.title,
    this.sourceURL,
    this.summary,
    this.wordCount,
    this.datePublished,
    this.dateUpdated,
  });
}
