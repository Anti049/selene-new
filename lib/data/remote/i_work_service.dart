import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:selene/core/database/models/chapter.dart';
import 'package:selene/core/database/models/work.dart';
import 'package:selene/data/local/file_service_registry.dart';

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
  }) : dio = dioClient ?? Dio() {
    dio.options.baseUrl = 'https://$siteDomain';
    dio.options.headers['User-Agent'] = 'Selene/1.0 (https://selene.app)';
    dio.interceptors.add(
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
    );
  }

  // Methods
  Future<WorkModel?> downloadWork(
    String sourceURL,
    String filePath, {
    bool downloadChapters = false,
    Function({int? progress, int? total, String? message})? onProgress,
  });

  Future<ChapterModel?> downloadChapter(
    ChapterModel source, {
    Function({int? progress, int? total, String? message})? onProgress,
  });

  Future<bool> requiresAdult(String sourceURL, {Response? response});
  Future<bool> requiresLogin(String sourceURL, {Response? response});
  Future<bool> tryLogin();

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
}
