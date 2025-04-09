import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:selene/core/database/database.dart';

part 'author_model.freezed.dart';
part 'author_model.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
abstract class AuthorModel with _$AuthorModel {
  const factory AuthorModel({
    required int id,
    required String sourceURL,
    required String name,
    @Default([]) List<String> works,
    @Default([]) List<String> bookmarkedWorks,
  }) = _AuthorModel;

  factory AuthorModel.fromJson(Map<String, dynamic> json) =>
      _$AuthorModelFromJson(json);

  factory AuthorModel.fromData(Author data) {
    return AuthorModel(
      id: data.id,
      sourceURL: data.sourceURL,
      name: data.name,
      works: [],
      bookmarkedWorks: [],
    );
  }
}
