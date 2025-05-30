// c:\Users\1099996508.adm\Documents\Coding\selene\lib\core\database\providers\preference_service_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:selene/core/constants/preference_constants.dart';
import 'package:selene/core/database/providers/isar_provider.dart';
import 'package:selene/core/database/tables/preferences_table.dart';

part 'preferences_stream_provider.g.dart';

@riverpod
Stream<Preferences?> preferencesStream(Ref ref) {
  // Watch the AsyncValue<Isar> state
  final isarAsyncValue = ref.watch(isarProvider);

  // Return the stream only when Isar data is available
  // For streams, returning an empty stream or a stream with an error might be alternatives,
  // but often waiting for the dependency is simplest.
  return isarAsyncValue.when(
    data:
        (isar) =>
            isar.preferences.watchObject(kPreferencesID, fireImmediately: true),
    // While loading/error, the stream isn't available yet. Riverpod handles this;
    // widgets watching this provider will show loading/error states inherited
    // from the isarProvider's state until Isar is ready.
    // You could return Stream.empty() or Stream.error() if needed, but often
    // letting Riverpod manage the AsyncValue propagation is cleaner.
    loading:
        () =>
            const Stream.empty(), // Or throw ProviderException('Isar loading...')
    error:
        (e, s) =>
            Stream.error(e, s), // Or throw ProviderException('Isar error...')
  );
}
