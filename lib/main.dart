// main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'views/reminder_view.dart';
import 'utils/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reminder App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: ReminderView(),
    );
  }
}
