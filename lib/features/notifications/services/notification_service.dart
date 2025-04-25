// Example: features/downloads/services/notification_service.dart
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_service.g.dart';

@Riverpod(keepAlive: true) // Keep alive
NotificationService notificationService(Ref ref) {
  return NotificationService();
}

class NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final int _notificationId = 1; // Unique ID for the download notification

  Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(
          '@mipmap/ic_launcher',
        ); // Use your app icon
    // Add iOS/macOS initialization if needed
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
    _createNotificationChannel(); // Create channel for Android 8+
  }

  Future<void> _createNotificationChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'download_channel', // id
      'Downloads', // title
      description: 'Notifications for ongoing downloads', // description
      importance:
          Importance.low, // Low importance for persistent, less intrusive
      playSound: false,
      enableVibration: false,
      showBadge: false,
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);
  }

  Future<void> showDownloadNotification({
    required String taskId, // To potentially update specific task info later
    required String workTitle,
    required String chapterTitle,
    required int progress,
    required int total,
    required String status,
    required int queueLength, // Display remaining items
  }) async {
    final String notificationTitle =
        'Downloading Chapters ($queueLength remaining)';
    final String notificationBody = '$workTitle - $chapterTitle: $status';

    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'download_channel', // Channel ID
          'Downloads', // Channel Name
          channelDescription: 'Notifications for ongoing downloads',
          importance: Importance.low,
          priority: Priority.low,
          ongoing: true, // Makes it persistent
          autoCancel: false, // Prevents dismissal by swipe
          showProgress: true,
          maxProgress: total,
          progress: progress,
          onlyAlertOnce: true, // Don't make sound/vibrate for updates
          ticker: notificationBody, // Shows briefly in status bar
        );
    final NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await _flutterLocalNotificationsPlugin.show(
      _notificationId,
      notificationTitle,
      notificationBody,
      platformChannelSpecifics,
      payload: 'download_queue', // Optional payload for notification tap
    );
  }

  Future<void> cancelDownloadNotification() async {
    await _flutterLocalNotificationsPlugin.cancel(_notificationId);
  }
}
