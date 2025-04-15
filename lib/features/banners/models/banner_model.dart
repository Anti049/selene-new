import 'package:freezed_annotation/freezed_annotation.dart';

part 'banner_model.freezed.dart';

enum BannerColor { primary, secondary, tertiary, error, neutral }

@freezed
class BannerModel with _$BannerModel {
  const BannerModel._();

  const factory BannerModel({
    required String label,
    required bool visible,
    required BannerColor color,
  }) = _BannerModel;
}
