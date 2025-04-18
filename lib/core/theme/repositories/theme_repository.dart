import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:selene/core/database/tables/app_themes_table.dart';
import 'package:selene/core/theme/data/predefined_themes.dart';
import 'package:selene/core/theme/models/app_theme.dart';

class ThemeRepository {
  final Isar _isar;

  ThemeRepository(this._isar);

  // --- Initialization ---
  Future<void> init({Color? dynamicColor}) async {
    // Load all prebuilt themes
    await _isar.writeTxn(() async {
      await _isar.isarThemes.putAll(
        prebuiltThemes.values.map((theme) => theme.toIsar()).toList(),
      );
      if (dynamicColor != null) {
        await _isar.isarThemes.put(
          AppTheme(
            id: 'dynamic',
            name: 'Dynamic',
            primary: dynamicColor,
            category: ThemeCategory.system,
          ).toIsar(),
        );
      }
    });
  }

  // --- Read Operations ---

  Future<List<AppTheme>> getAllThemes() async {
    final themes = await _isar.isarThemes.where().findAll();
    return themes.map((theme) => theme.toModel()).toList();
  }

  List<AppTheme> getAllThemesSync() {
    final themes = _isar.isarThemes.where().findAllSync();
    return themes.map((theme) => theme.toModel()).toList();
  }

  Future<List<AppTheme>> getThemesByCategory(ThemeCategory category) async {
    final themes =
        await _isar.isarThemes.filter().categoryEqualTo(category).findAll();
    return themes.map((theme) => theme.toModel()).toList();
  }

  List<AppTheme> getThemesByCategorySync(ThemeCategory category) {
    final themes =
        _isar.isarThemes.filter().categoryEqualTo(category).findAllSync();
    return themes.map((theme) => theme.toModel()).toList();
  }

  Future<AppTheme?> getThemeById(String id) async {
    final theme = await _isar.isarThemes.where().idEqualTo(id).findFirst();
    return theme?.toModel();
  }

  AppTheme? getThemeByIdSync(String id) {
    final theme = _isar.isarThemes.where().idEqualTo(id).findFirstSync();
    return theme?.toModel();
  }

  Future<Id?> getIsarIdById(String id) async {
    final theme = await _isar.isarThemes.where().idEqualTo(id).findFirst();
    return theme?.isarID;
  }

  Id? getIsarIdByIdSync(String id) {
    final theme = _isar.isarThemes.where().idEqualTo(id).findFirstSync();
    return theme?.isarID;
  }

  // --- Write Operations ---

  Future<void> upsertTheme(AppTheme theme) async {
    final isarTheme = theme.toIsar();
    await _isar.writeTxn(() async {
      await _isar.isarThemes.put(isarTheme);
    });
  }

  void upsertThemeSync(AppTheme theme) {
    final isarTheme = theme.toIsar();
    _isar.writeTxnSync(() {
      _isar.isarThemes.putSync(isarTheme);
    });
  }

  Future<void> deleteTheme(String id) async {
    await _isar.writeTxn(() async {
      await _isar.isarThemes.deleteById(id);
    });
  }

  void deleteThemeSync(String id) {
    _isar.writeTxnSync(() {
      _isar.isarThemes.deleteByIdSync(id);
    });
  }
}
