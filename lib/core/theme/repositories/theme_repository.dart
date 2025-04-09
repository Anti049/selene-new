import 'package:selene/core/theme/models/app_theme.dart';

abstract class ThemeRepository {
  Future<AppTheme?> getThemeById(String id);
  // Add methods for watching selected ID, saving themes etc. later
}
