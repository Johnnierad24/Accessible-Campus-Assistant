import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'reminders_service.dart';

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;

    tz.initializeTimeZones();
    final localTz = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(localTz));

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidInit);
    await _plugin.initialize(initSettings);
    _initialized = true;
  }

  NotificationDetails _details() {
    const androidDetails = AndroidNotificationDetails(
      'reminders',
      'Reminders',
      channelDescription: 'Reminder alerts',
      importance: Importance.max,
      priority: Priority.high,
    );
    return const NotificationDetails(android: androidDetails);
  }

  Future<int> showReminder(ReminderItem item) async {
    final id = item.id.hashCode & 0x7fffffff;
    await _plugin.show(
      id,
      item.title,
      item.time.isNotEmpty ? item.time : null,
      _details(),
    );
    return id;
  }

  Future<int> scheduleReminder(ReminderItem item, DateTime when) async {
    final id = item.id.hashCode & 0x7fffffff;
    final tzTime = tz.TZDateTime.from(when, tz.local);
    await _plugin.zonedSchedule(
      id,
      item.title,
      item.time.isNotEmpty ? item.time : null,
      tzTime,
      _details(),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: item.id,
      matchDateTimeComponents: DateTimeComponents.time,
    );
    return id;
  }

  Future<void> cancel(int id) async {
    await _plugin.cancel(id);
  }
}
