import 'package:freezed_annotation/freezed_annotation.dart';

part 'author.freezed.dart';

@freezed
class AuthorModel with _$AuthorModel {
  const AuthorModel._();

  const factory AuthorModel({
    int? id,
    required String name,
    String? sourceURL,
  }) = _AuthorModel;
}
