import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:isar/isar.dart';
import 'package:selene/core/theme/models/app_theme.dart';
import 'package:selene/core/utils/isar.dart';

part 'app_themes_table.g.dart';

@collection
@Name('AppThemes')
class IsarTheme {
  Id get isarID => fastHash(id);

  @Index(unique: true, caseSensitive: false)
  late String id;
  late String name;
  @enumerated
  late ThemeCategory category;
  late String primary;
  String? secondary;
  String? tertiary;
  String? error;
  String? neutral;
  String? neutralVariant;
  @enumerated
  late FlexSchemeVariant variant;
  late bool isPrebuilt;
  late bool isEditable;

  IsarTheme();

  AppTheme toModel() {
    return AppTheme(
      id: id,
      name: name,
      category: category,
      primary: primary.toColor,
      secondary: secondary?.toColor,
      tertiary: tertiary?.toColor,
      error: error?.toColor,
      neutral: neutral?.toColor,
      neutralVariant: neutralVariant?.toColor,
      variant: variant,
      isPrebuilt: isPrebuilt,
      isEditable: isEditable,
    );
  }
}
