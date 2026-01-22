import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'dart:io';


class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tz.initializeTimeZones();

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidInit);

    await _plugin.initialize(initSettings);

    // Android 13+ permission request
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await android?.requestNotificationsPermission();
  }

  Future<void> scheduleSessionReminder({
    required int id,
    required String title,
    required DateTime dateTime,
  }) async {
    if (!Platform.isAndroid) return; // <-- add this

    if (dateTime.isBefore(DateTime.now())) return;

    const androidDetails = AndroidNotificationDetails(
      'study_reminders',
      'Study Reminders',
      channelDescription: 'Notifications for scheduled study sessions',
      importance: Importance.high,
      priority: Priority.high,
    );

    const details = NotificationDetails(android: androidDetails);

    await _plugin.zonedSchedule(
      id,
      'Study Reminder',
      title,
      tz.TZDateTime.from(dateTime, tz.local),
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: null,
    );
  }

  Future<void> cancelReminder(int id) async {
    await _plugin.cancel(id);
  }
}
