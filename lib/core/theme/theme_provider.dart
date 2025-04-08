import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:selene/core/theme/models/app_theme.dart';
import 'package:selene/core/theme/repository/system/theme_system.dart';
import 'package:selene/core/theme/theme_repository.dart';

part 'theme_provider.g.dart';

@riverpod
FutureOr<AppTheme> activeTheme(Ref ref) async {
  final themeID = 'system';

  final repository = ref.watch(themeRepositoryProvider);

  final theme = await repository.getThemeById(themeID);

  return theme ?? themeSystem;
}
