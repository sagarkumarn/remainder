import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  //NotificationService a singleton object
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  static const channelId = '123';

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');



    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
        
            macOS: null);

    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        );
  }

  AndroidNotificationDetails _androidNotificationDetails =
      AndroidNotificationDetails(
    'channel ID',
    'channel name',
   
    playSound: true,
    priority: Priority.high,
    importance: Importance.high,
  );

  Future<void> showNotifications() async {
    await flutterLocalNotificationsPlugin.show(
      0,
      "Notification Title",
      "This is the Notification Body!",
      NotificationDetails(android: _androidNotificationDetails),
    );
  }

  Future<void> scheduleNotifications() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        "Notification Title",
        "This is the Notification Body!",
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        NotificationDetails(android: _androidNotificationDetails),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> cancelNotifications(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

Future selectNotification(String payload) async {
  //handle your logic here
}
// // utils/notification_service.dart
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter/material.dart';
// // ignore: depend_on_referenced_packages
// import 'package:timezone/timezone.dart' as tz;
// // ignore: depend_on_referenced_packages
// import 'package:timezone/data/latest.dart' as tz;

// class NotificationService {
//   static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   static Future<void> initialize() async {
//     tz.initializeTimeZones();
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     const InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: initializationSettingsAndroid,
//     );

//     await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }

//   static Future<void> scheduleNotification({
//     required String day,
//     required TimeOfDay time,
//     required String activity,
//   }) async {
//     const androidDetails = AndroidNotificationDetails(
//       'reminder_channel',
//       'Reminders',
//       importance: Importance.max,
//       priority: Priority.high,
//     );

//     const notificationDetails = NotificationDetails(
//       android: androidDetails,
//     );

//     final scheduledTime = _nextInstanceOfDayAndTime(day, time);
// await _flutterLocalNotificationsPlugin.zonedSchedule(
//         0,
//         "Notification Title",
//         "This is the Notification Body!",
//         tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
//         notificationDetails,
//         androidAllowWhileIdle: true,
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.absoluteTime);
//     // await _flutterLocalNotificationsPlugin.zonedSchedule(
//     //   0,
//     //   'Reminder',
//     //   activity,
//     //   scheduledTime,
//     //   notificationDetails,
//     //   // ignore: deprecated_member_use
//     //   androidAllowWhileIdle: true,
//     //   uiLocalNotificationDateInterpretation:
//     //       UILocalNotificationDateInterpretation.wallClockTime,
//     //   matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
//     // );
//   }

//   static tz.TZDateTime _nextInstanceOfDayAndTime(String day, TimeOfDay time) {
//     final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
//     final int weekday = _dayToWeekday(day);
//     tz.TZDateTime scheduledDate = tz.TZDateTime(
//       tz.local,
//       now.year,
//       now.month,
//       now.day,
//       time.hour,
//       time.minute,
//     );

//     while (scheduledDate.weekday != weekday || scheduledDate.isBefore(now)) {
//       scheduledDate = scheduledDate.add(const Duration(days: 1));
//     }

//     return scheduledDate;
//   }

//   static int _dayToWeekday(String day) {
//     switch (day) {
//       case 'Monday':
//         return DateTime.monday;
//       case 'Tuesday':
//         return DateTime.tuesday;
//       case 'Wednesday':
//         return DateTime.wednesday;
//       case 'Thursday':
//         return DateTime.thursday;
//       case 'Friday':
//         return DateTime.friday;
//       case 'Saturday':
//         return DateTime.saturday;
//       case 'Sunday':
//         return DateTime.sunday;
//       default:
//         return DateTime.monday;
//     }
//   }
// }
