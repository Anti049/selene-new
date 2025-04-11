import 'package:freezed_annotation/freezed_annotation.dart';

part 'series.freezed.dart';

@freezed
class SeriesModel with _$SeriesModel {
  const SeriesModel._();

  const factory SeriesModel({
    int? id,
    required String title,
    String? sourceURL,
    String? summary,
    int? wordCount,
    DateTime? datePublished,
    DateTime? dateUpdated,
  }) = _SeriesModel;
}
