import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:selene/core/database/database.dart';

part 'chapter_model.freezed.dart';
part 'chapter_model.g.dart';

@freezed
abstract class ChapterModel with _$ChapterModel {
  const factory ChapterModel({
    required int id,
    required String sourceURL,
    required int workID,
    required String title,
    String? content,
    required DateTime datePublished,
    required int wordCount,
    required int chapterNumber,
  }) = _ChapterModel;

  factory ChapterModel.fromJson(Map<String, dynamic> json) =>
      _$ChapterModelFromJson(json);

  factory ChapterModel.fromData(Chapter data) {
    return ChapterModel(
      id: data.id,
      sourceURL: data.sourceURL,
      workID: data.workID,
      title: data.title,
      content: data.content,
      datePublished: DateTime.parse(data.datePublished),
      wordCount: data.wordCount,
      chapterNumber: data.chapterNumber,
    );
  }
}
