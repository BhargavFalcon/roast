import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final FlutterLocalNotificationsPlugin _fln =
      FlutterLocalNotificationsPlugin();

  static const String _eveningChannelId = 'daily_evening_channel';
  static const String _nightChannelId = 'daily_night_channel';

  Future<void> init() async {
    tz.initializeTimeZones();
    try {
      final String localTz = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(localTz));
    } catch (_) {
      tz.setLocalLocation(tz.getLocation('UTC'));
    }

    const AndroidInitializationSettings androidInit =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosInit = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    await _fln.initialize(
      const InitializationSettings(android: androidInit, iOS: iosInit),
      onDidReceiveNotificationResponse: _onTapNotification,
      onDidReceiveBackgroundNotificationResponse: _onTapNotificationBackground,
    );

    if (Platform.isAndroid) {
      await _fln
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestNotificationsPermission();
    }
  }

  /// 🔔 Schedule 6:20 PM & 10:20 PM
  Future<void> scheduleDailyNotifications() async {
    await cancelDailyNotifications();

    // 6:20 PM
    await _zonedDaily(
      id: 620,
      hour: 18,
      minute: 20,
      androidChannelId: _eveningChannelId,
      androidChannelName: 'Evening Notification',
      androidChannelDescription: 'Shows every day at 6:20 PM',
      title: 'Ready to roast? 🔥',
      body: 'Upload a photo and get roasted instantly—no mercy, just comedy!',
      payload: 'evening',
    );

    // 10:20 PM
    await _zonedDaily(
      id: 1020,
      hour: 22,
      minute: 20,
      androidChannelId: _nightChannelId,
      androidChannelName: 'Night Notification',
      androidChannelDescription: 'Shows every day at 10:20 PM',
      title: 'Your self-esteem can wait 😈',
      body: 'One last free roast left—use it before it disappears!',
      payload: 'night',
    );
  }

  /// ❌ Cancel only these notifications
  Future<void> cancelDailyNotifications() async {
    await _fln.cancel(620);
    await _fln.cancel(1020);
  }

  /// ❌ Cancel all
  Future<void> cancelAll() => _fln.cancelAll();

  /// ⏰ Helper
  Future<void> _zonedDaily({
    required int id,
    required int hour,
    required int minute,
    required String androidChannelId,
    required String androidChannelName,
    required String androidChannelDescription,
    required String title,
    required String body,
    String? payload,
  }) async {
    final tz.TZDateTime firstTime = _nextInstanceOf(hour, minute);

    final NotificationDetails details = NotificationDetails(
      android: AndroidNotificationDetails(
        androidChannelId,
        androidChannelName,
        channelDescription: androidChannelDescription,
        importance: Importance.high,
        priority: Priority.high,
        playSound: true,
        enableVibration: true,
      ),
      iOS: const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    await _fln.zonedSchedule(
      id,
      title,
      body,
      firstTime,
      details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: payload,
    );
  }

  tz.TZDateTime _nextInstanceOf(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }

  void _onTapNotification(NotificationResponse response) {
    // Handle navigation here if needed
  }
}

@pragma('vm:entry-point')
void _onTapNotificationBackground(NotificationResponse response) {
  // Handle background tap
}
