import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:selene/core/database/database.dart';
import 'package:selene/core/database/providers/database_provider.dart';
import 'package:selene/core/logging/logger_provider.dart';
import 'package:selene/core/theme/data/system/theme_system.dart';
import 'package:selene/core/theme/models/app_theme.dart';
import 'package:selene/core/theme/providers/theme_providers.dart';
import 'package:selene/routing/router.dart';
import 'package:system_theme/system_theme.dart';

void main() async {
  // Ensure plugin services are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Drift database
  final database = AppDatabase();
  try {
    await database.themesDao.ensureDefaultThemes();
  } catch (e) {
    debugPrint('Error initializing database: $e');
  }

  // Create Riverpod container
  final container = ProviderContainer(
    overrides: [appDatabaseProvider.overrideWithValue(database)],
  );

  // Initialize themes
  AppTheme initialTheme;
  try {
    final themeID =
        'gaziter'; // TODO: Replace with your logic to get the theme ID
    final themeRepository = container.read(themeRepositoryProvider);
    initialTheme = await themeRepository.getThemeById(themeID) ?? themeSystem;
  } catch (e) {
    container.read(loggerProvider).e('Error getting theme ID: $e');
    initialTheme = themeSystem;
  } finally {
    container.dispose();
  }

  // Initialize system theme
  await SystemTheme.accentColor.load();

  // Run the app
  runApp(
    ProviderScope(
      overrides: [
        appDatabaseProvider.overrideWithValue(database),
        activeThemeProvider.overrideWithValue(initialTheme),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  MainApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get providers
    final database = ref.watch(appDatabaseProvider);

    // Handle dynamic color support
    return SystemThemeBuilder(
      builder: (context, accent) {
        // Initialize app themes
        try {
          database.themesDao.ensureDefaultThemes(dynamicColor: accent.accent);
        } catch (e) {
          ref.read(loggerProvider).e('Error initializing themes: $e');
        }

        // Get current theme
        // For now, just use system theme
        final theme = ref.watch(activeThemeProvider);

        // Get current theme mode
        final themeMode = ThemeMode.system;

        return MaterialApp.router(
          title: 'Selene',
          themeMode: themeMode,
          theme: theme.light(),
          darkTheme: theme.dark(),
          routerConfig: _appRouter.config(),
        );
      },
    );
  }
}
