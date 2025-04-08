import 'package:drift/drift.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:selene/core/theme/models/app_theme.dart';
import 'package:selene/core/utils/converters.dart';

class Themes extends Table {
  @override
  String? get tableName => 'themes';

  @override
  Set<Column> get primaryKey => {id};

  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  IntColumn get category => intEnum<ThemeCategory>()();

  TextColumn get primary => text().map(const ColorStringConverter())();
  TextColumn get secondary =>
      text().map(const ColorStringConverter()).nullable()();
  TextColumn get tertiary =>
      text().map(const ColorStringConverter()).nullable()();
  TextColumn get error => text().map(const ColorStringConverter()).nullable()();
  TextColumn get neutral =>
      text().map(const ColorStringConverter()).nullable()();
  TextColumn get neutralVariant =>
      text().map(const ColorStringConverter()).nullable()();
  IntColumn get variant => intEnum<FlexSchemeVariant>()();
  BoolColumn get isPrebuilt => boolean().withDefault(const Constant(false))();
  BoolColumn get isEditable => boolean().withDefault(const Constant(true))();
}
