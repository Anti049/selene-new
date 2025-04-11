import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:selene/core/database/providers/isar_provider.dart';
import 'package:selene/core/logging/logger_provider.dart';
import 'package:selene/core/theme/providers/theme_repository_provider.dart';
import 'package:selene/features/settings/screens/appearance/providers/appearance_preferences.dart';
import 'package:selene/routing/router.dart';
import 'package:system_theme/system_theme.dart';

late Isar isarInstance;

void main() async {
  // Ensure plugin services are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize system theme
  await SystemTheme.accentColor.load();
  final accentColor = SystemTheme.accentColor.accent;

  // Initialize Isar provider
  final container = ProviderContainer();
  try {
    // Wait for Isar to be ready
    await container.read(isarProvider.future);
    // Now initialize themes using the repository (which depends on Isar)
    await container
        .read(themeRepositoryProvider)
        .init(dynamicColor: accentColor);
  } catch (e, stackTrace) {
    final logger = container.read(loggerProvider);
    logger.e('Error during app initialization: $e', stackTrace: stackTrace);
  }

  // Run the app
  runApp(UncontrolledProviderScope(container: container, child: MainApp()));
}

class MainApp extends ConsumerWidget {
  MainApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the Isar provider. This will handle the loading/error states.
    final isarAsyncValue = ref.watch(isarProvider);

    return isarAsyncValue.when(
      data: (isar) {
        // Get providers
        final themeRepository = ref.watch(themeRepositoryProvider);
        final appearancePrefs = ref.watch(appearancePreferencesProvider);

        // Handle dynamic color support
        return SystemThemeBuilder(
          builder: (context, accent) {
            // Get current theme
            final themeID = appearancePrefs.themeID.value ?? 'system';
            // Use async getThemeById if ThemeRepository uses async methods
            final activeTheme = themeRepository.getThemeByIdSync(
              themeID,
            ); // Keep sync if repo supports it

            // Get current theme mode
            final themeMode = appearancePrefs.themeMode.value;

            return MaterialApp.router(
              title: 'Selene',
              themeMode: themeMode,
              theme:
                  activeTheme?.light() ?? ThemeData.light(useMaterial3: true),
              darkTheme:
                  activeTheme?.dark() ?? ThemeData.dark(useMaterial3: true),
              debugShowCheckedModeBanner: kDebugMode,
              routerConfig: _appRouter.config(),
            );
          },
        );
      },
      loading: () {
        // Show a loading indicator while Isar initializes
        // Could be your splash screen
        return const MaterialApp(
          home: Scaffold(body: Center(child: CircularProgressIndicator())),
        );
      },
      error: (error, stackTrace) {
        final logger = ref.read(loggerProvider);
        logger.e('Isar Initialization Error: $error', stackTrace: stackTrace);
        // Show an error screen if Isar fails to initialize
        return MaterialApp(
          home: Scaffold(
            body: Center(child: Text('Failed to initialize database: $error')),
          ),
        );
      },
    );
  }
}
