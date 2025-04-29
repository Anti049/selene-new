import 'package:logger/logger.dart';
import 'package:selene/core/database/models/work.dart';
import 'package:selene/features/settings/screens/data_storage/providers/data_storage_preferences.dart';

abstract class IFileService {
  // Service metadata
  final String serviceID;
  final List<String> acceptedExtensions;
  // Logging
  final Logger logger;
  final DataStoragePreferences dataStoragePrefs;

  // Constructor
  IFileService({
    required this.serviceID,
    required this.acceptedExtensions,
    required this.logger,
    required this.dataStoragePrefs,
  });

  // Methods
  Future<String> saveFile(WorkModel work, String filePath);

  Future<WorkModel?> loadFile(String filePath);
  Future<List<WorkModel>> loadAllFiles(String directoryPath);

  Future<bool> deleteFile(String filePath);

  bool isFileValid(String filePath) {
    final extension = filePath.split('.').last.toLowerCase();
    return acceptedExtensions.contains('.$extension');
  }
}
