import 'package:selene/core/database/daos/themes_dao.dart';
import 'package:selene/core/theme/models/app_theme.dart';
import 'package:selene/core/theme/repositories/theme_repository.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemesDao _themesDao;

  ThemeRepositoryImpl(this._themesDao);

  @override
  Future<AppTheme?> getThemeById(String id) async {
    return _themesDao.getThemeById(id);
  }
}
