import 'package:freezed_annotation/freezed_annotation.dart';

part 'chapter.freezed.dart';

@freezed
class ChapterModel with _$ChapterModel {
  const ChapterModel._();

  const factory ChapterModel({
    int? id,
    required String title,
    String? sourceURL,
    required int index,
    int? wordCount,
    DateTime? datePublished,
    String? content,
    String? summary,
    String? startNotes,
    String? endNotes,
    @Default(false) bool isRead,
  }) = _ChapterModel;

  String createContent() {
    String fullHTML = '''
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:epub="http://www.idpf.org/2007/ops" xml:lang="en" lang="en">
<head>
  <meta charset="utf-8"/>
  <title>$title</title>
</head>
<body>
  <h1>$title</h1>
  ${startNotes != null ? '<p>$startNotes</p>' : ''}
  ${content ?? ''}
  ${summary != null ? '<p>$summary</p>' : ''}
  ${endNotes != null ? '<p>$endNotes</p>' : ''}
</body>
</html>
''';

    return fullHTML;
  }
}
