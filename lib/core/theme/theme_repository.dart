// lib/core/theme/theme_repository.dart (Simplified Example)
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:selene/core/database/daos/themes_dao.dart';
import 'package:selene/core/database/database_provider.dart';
import 'package:selene/core/theme/models/app_theme.dart';

part 'theme_repository.g.dart';

abstract class ThemeRepository {
  Future<AppTheme?> getThemeById(String id);
  // Add methods for watching selected ID, saving themes etc. later
}

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemesDao _themesDao;

  ThemeRepositoryImpl(this._themesDao);

  @override
  Future<AppTheme?> getThemeById(String id) async {
    return _themesDao.getThemeById(id);
  }
}

@riverpod
ThemeRepository themeRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return ThemeRepositoryImpl(db.themesDao);
}
