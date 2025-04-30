import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart' as p;
import 'package:selene/core/database/models/chapter.dart';
import 'package:selene/core/database/models/work.dart';
import 'package:selene/data/local/file_service_registry.dart';
import 'package:selene/features/settings/screens/data_storage/providers/data_storage_preferences.dart';

abstract class IWorkService {
  // Service metadata
  final String serviceID;
  final String serviceName;
  final String serviceIcon;
  // Site data
  final String siteDomain;
  final List<String> acceptedDomains;
  final List<String> validPatterns;
  final List<String> exampleURLs;
  // Authentication
  final String email;
  final String password;
  final bool hasAdultWorks;
  // Web requests
  final Dio dio;
  // Logging
  final Logger logger;
  // Local file services
  final FileServiceRegistry fileServiceRegistry;
  final DataStoragePreferences dataStoragePrefs;

  // Constructor
  IWorkService({
    required this.serviceID,
    required this.serviceName,
    required this.serviceIcon,
    required this.siteDomain,
    required this.acceptedDomains,
    required this.validPatterns,
    required this.exampleURLs,
    this.email = '',
    this.password = '',
    this.hasAdultWorks = false,
    Dio? dioClient,
    required this.logger,
    required this.fileServiceRegistry,
    required this.dataStoragePrefs,
  }) : dio = dioClient ?? Dio() {
    dio.options.baseUrl = 'https://$siteDomain';
    dio.options.headers.addAll({
      'User-Agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36', // More common browser UA
      'Accept':
          'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9',
      'Accept-Language': 'en-US,en;q=0.9',
      // Add other headers if needed
    });
    dio.interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add any request interceptors here if needed
          return handler.next(options);
        },
        onResponse: (response, handler) {
          // Add any response interceptors here if needed
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          // Handle errors globally
          return handler.next(e);
        },
      ),
      RetryInterceptor(
        dio: dio,
        retries: 3, // Number of retries on failure
        retryDelays: const [
          Duration(seconds: 1),
          Duration(seconds: 2),
          Duration(seconds: 3),
        ],
      ),
    ]);
  }

  // Methods
  Future<WorkModel?> downloadWork(
    String sourceURL, {
    Function({int? progress, int? total, String? message})? onProgress,
  });

  Future<ChapterModel?> downloadChapter(
    ChapterModel source, {
    Function({int? progress, int? total, String? message})? onProgress,
  });

  Future<bool> requiresAdult(String sourceURL, {Response? response});
  Future<bool> requiresLogin(String sourceURL, {Response? response});
  Future<bool> tryLogin();

  // Helper methods
  bool isURLValid(String sourceURL) {
    // Use HTTPS scheme as a basic validation check
    if (sourceURL.isEmpty) return false;
    sourceURL = sourceURL.trim().replaceFirst('http://', 'https://');
    // Validate against regex patterns (validPatterns)
    for (final pattern in validPatterns) {
      if (RegExp(pattern).hasMatch(sourceURL)) {
        return true;
      }
    }
    // If no patterns matched, return false
    return false;
  }

  String determineSavePath(String workTitle, String workId) {
    final libraryDir = dataStoragePrefs.libraryFolder.get();
    if (libraryDir.isEmpty) {
      throw Exception("Library folder is not set in preferences.");
    }
    // Sanitize filename (remove invalid characters)
    String sanitizedTitle =
        workTitle
            .replaceAll(RegExp(r'[<>:"/\\|?*]'), '_') // Replace invalid chars
            .replaceAll(RegExp(r'\s+'), ' ') // Collapse whitespace
            .trim();
    if (sanitizedTitle.length > 100) {
      // Limit length
      sanitizedTitle = sanitizedTitle.substring(0, 100);
    }
    if (sanitizedTitle.isEmpty) {
      sanitizedTitle = "work_$workId"; // Fallback if title is empty/invalid
    }

    // Use path package for joining
    return p.join(libraryDir, '$sanitizedTitle.epub');
  }
}
