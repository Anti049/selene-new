import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:selene/core/logging/logger_provider.dart';
import 'package:selene/data/local/i_file_service.dart';
import 'package:selene/data/local/epub_file_service.dart';
import 'package:selene/features/settings/screens/data_storage/providers/data_storage_preferences.dart';

part 'file_service_registry.g.dart';

class FileServiceRegistry {
  final List<IFileService> services;

  FileServiceRegistry(this.services);

  IFileService? getServiceByExtension(String? extension) {
    if (extension == null || extension.isEmpty) return null;
    for (final service in services) {
      if (service.acceptedExtensions.contains(extension)) {
        return service;
      }
    }
    return null;
  }

  List<String> get allAcceptedExtensions {
    final extensions = <String>{};
    for (final service in services) {
      for (final ext in service.acceptedExtensions) {
        extensions.add(ext);
      }
    }
    return extensions.toList();
  }
}

@riverpod
FileServiceRegistry fileServiceRegistry(Ref ref) {
  final logger = ref.watch(loggerProvider);
  final dataStoragePrefs = ref.watch(dataStoragePreferencesProvider);
  return FileServiceRegistry([
    EpubFileService(logger: logger, dataStoragePrefs: dataStoragePrefs),
  ]);
}
