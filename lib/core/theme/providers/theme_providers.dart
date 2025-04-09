import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:selene/core/database/providers/database_provider.dart';
import 'package:selene/core/logging/logger_provider.dart';
import 'package:selene/core/theme/models/app_theme.dart';
import 'package:selene/core/theme/data/system/theme_system.dart';
import 'package:selene/core/theme/repositories/theme_repository.dart';
import 'package:selene/core/theme/repositories/theme_repository_impl.dart';

part 'theme_providers.g.dart';

@riverpod
AppTheme activeTheme(Ref ref) {
  ref
      .read(loggerProvider)
      .e('activeThemeProvider was accessed before being overwritten!');
  return themeSystem;
}

@riverpod
ThemeRepository themeRepository(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return ThemeRepositoryImpl(db.themesDao);
}
