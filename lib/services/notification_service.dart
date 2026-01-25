import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  NotificationService._();
  static final instance = NotificationService._();

  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidInit);

    await _plugin.initialize(initSettings);

    if (Platform.isAndroid) {
      final android = _plugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

      // Create channel (important for Android 8+)
      await android?.createNotificationChannel(
        const AndroidNotificationChannel(
          'study_reminders',
          'Study Reminders',
          description: 'Local notifications for study sessions',
          importance: Importance.max,
        ),
      );

      // Android 13+ permission
      await android?.requestNotificationsPermission();
    }
  }

  NotificationDetails _details() {
    const android = AndroidNotificationDetails(
      'study_reminders',
      'Study Reminders',
      channelDescription: 'Local notifications for study sessions',
      importance: Importance.max,
      priority: Priority.max,
    );
    return const NotificationDetails(android: android);
  }

  Future<void> showSessionCreated({
    required String subject,
    required String title,
  }) async {
    if (!Platform.isAndroid) return;

    await _plugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000, // unique id
      'Session added',
      '$subject • $title',
      _details(),
    );
  }
}
