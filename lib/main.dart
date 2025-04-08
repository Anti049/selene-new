import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:selene/core/database/database.dart';
import 'package:selene/core/database/database_provider.dart';
import 'package:selene/core/theme/theme_provider.dart';
import 'package:selene/routing/router.dart';
import 'package:system_theme/system_theme.dart';

void main() async {
  // Ensure plugin services are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Drift database
  final database = AppDatabase();

  // Initialize system theme
  await SystemTheme.accentColor.load();

  // Run the app
  runApp(
    ProviderScope(
      overrides: [appDatabaseProvider.overrideWithValue(database)],
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
          debugPrint('Error initializing themes: $e');
        }

        // Get current theme
        // For now, just use system theme
        final theme = ref.watch(activeThemeProvider);

        // Get current theme mode
        final themeMode = ThemeMode.system;

        return theme.when(
          data: (data) {
            return MaterialApp.router(
              title: 'Selene',
              themeMode: themeMode,
              theme: data.light(),
              darkTheme: data.dark(),
              routerConfig: _appRouter.config(),
            );
          },
          error: (error, stack) {
            return MaterialApp.router(
              title: 'Selene',
              themeMode: themeMode,
              routerConfig: _appRouter.config(),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
