import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:selene/core/database/providers/isar_provider.dart'; // Your Isar provider
import 'package:selene/core/theme/repositories/theme_repository.dart'; // Your repository

part 'theme_repository_provider.g.dart'; // Will be generated

@riverpod
ThemeRepository themeRepository(Ref ref) {
  // Watch the AsyncValue<Isar> state
  final isarAsyncValue = ref.watch(isarProvider);

  // Return the repository only when Isar data is available
  // Otherwise, throw an exception, which Riverpod will handle and
  // propagate as an error state to downstream watchers.
  return isarAsyncValue.when(
    data: (isar) => ThemeRepository(isar), // Success: Create the repository
    loading:
        () =>
            throw const ProviderException(
              // Loading: Repository cannot be created yet
              'Isar instance is loading',
              StackTrace.empty,
            ),
    error:
        (error, stackTrace) =>
            throw ProviderException(
              // Error: Repository cannot be created
              'Failed to initialize Isar for ThemeRepository',
              stackTrace,
              error,
            ),
  );
}

// Helper class for more specific provider errors (optional but good practice)
class ProviderException implements Exception {
  final String message;
  final StackTrace stackTrace;
  final Object? originalError;
  const ProviderException(this.message, this.stackTrace, [this.originalError]);

  @override
  String toString() {
    return 'ProviderException: $message${originalError != null ? '\nOriginal Error: $originalError' : ''}';
  }
}
