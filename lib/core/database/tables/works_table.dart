import 'package:isar/isar.dart';
import 'package:selene/core/database/models/work.dart';
import 'package:selene/core/database/tables/authors_table.dart';
import 'package:selene/core/database/tables/chapters_table.dart';
import 'package:selene/core/database/tables/fandoms_table.dart';
import 'package:selene/core/database/tables/series_table.dart';
import 'package:selene/core/database/tables/tags_table.dart';

part 'works_table.g.dart';

@collection
@Name('Works')
class Work {
  Id id = Isar.autoIncrement;

  @Index()
  late String title;
  @Index(unique: true, caseSensitive: false)
  String? sourceURL;
  String? summary;
  @Index()
  final fandoms = IsarLinks<Fandom>();
  int? wordCount;
  @enumerated
  late WorkStatus status;
  String? coverURL;
  DateTime? datePublished;
  DateTime? dateUpdated;
  @Index()
  final authors = IsarLinks<Author>();
  @Index()
  final series = IsarLinks<Series>();
  @Index()
  final tags = IsarLinks<Tag>();
  final chapters = IsarLinks<Chapter>();
  late int lastReadChapterIndex;
  late double lastReadScrollOffset;

  Work({
    required this.title,
    this.sourceURL,
    this.summary,
    this.wordCount,
    this.status = WorkStatus.unknown,
    this.coverURL,
    this.datePublished,
    this.dateUpdated,
    this.lastReadChapterIndex = 0,
    this.lastReadScrollOffset = 0.0,
  });
}
