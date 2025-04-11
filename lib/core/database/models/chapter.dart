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
  }) = _ChapterModel;
}
