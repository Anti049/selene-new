import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:selene/core/database/models/work.dart';

part 'fandom.freezed.dart';

@freezed
class FandomModel with _$FandomModel {
  const FandomModel._();

  const factory FandomModel({
    int? id,
    required String name,
    @Default([]) List<String> sourceURLs,
    @Default([]) List<WorkModel> works,
    @Default([]) List<String> aliases,
  }) = _FandomModel;
}
