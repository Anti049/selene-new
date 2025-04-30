import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:selene/core/logging/logger_provider.dart';
import 'package:selene/data/local/file_service_registry.dart';
import 'package:selene/data/remote/ao3_work_service.dart';
import 'package:selene/data/remote/i_work_service.dart';
import 'package:selene/features/settings/screens/data_storage/providers/data_storage_preferences.dart';

part 'work_service_registry.g.dart';

class WorkServiceRegistry {
  final List<IWorkService> services;

  WorkServiceRegistry(this.services);

  IWorkService? getServiceByURL(String? url) {
    if (url == null || url.isEmpty) return null;
    for (final service in services) {
      if (service.isURLValid(url)) {
        return service;
      }
    }
    return null;
  }
}

@riverpod
WorkServiceRegistry workServiceRegistry(Ref ref) {
  // Get dependencies
  final fileServiceRegistry = ref.watch(fileServiceRegistryProvider);
  final dataStoragePrefs = ref.watch(dataStoragePreferencesProvider);
  // Ensure the file service registry is initialized before creating work services
  if (fileServiceRegistry.services.isEmpty) {
    throw Exception('File service registry is not initialized.');
  }
  final logger = ref.watch(loggerProvider);
  return WorkServiceRegistry([
    AO3WorkService(
      logger: logger,
      fileServiceRegistry: fileServiceRegistry,
      dataStoragePrefs: dataStoragePrefs,
    ),
  ]);
}
