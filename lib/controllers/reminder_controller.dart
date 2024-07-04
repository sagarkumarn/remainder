import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/reminder.dart';
import 'package:reminder/utils/notification_service.dart';

class ReminderController extends GetxController {
  var reminders = <Reminder>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadReminders();
  }

  void addReminder(Reminder reminder, BuildContext context) async {
    if (reminders.contains(reminder)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Reminder already exists')),
      );
    } else {
      try {
        reminders.insert(0, reminder);
        await NotificationService().showNotifications();
        await saveReminders();
      } catch (err) {
        print(err);
      }
      reminders.refresh();
    }
  }

  void removeReminder(String id) async {
    reminders.removeWhere((element) => element.id == id);
    await saveReminders();
    reminders.refresh();
  }

  String formatTime(int hour, int minute) {
    final minuteStr = minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    int hour12 = hour % 12;
    if (hour12 == 0) {
      hour12 = 12;
    }
    return '$hour12:$minuteStr $period';
  }

  Future<void> saveReminders() async {
    final prefs = await SharedPreferences.getInstance();
    final remindersJson = jsonEncode(reminders.map((reminder) => reminder.toJson()).toList());
    await prefs.setString('reminders', remindersJson);
  }

  Future<void> loadReminders() async {
    final prefs = await SharedPreferences.getInstance();
    final remindersJson = prefs.getString('reminders');
    if (remindersJson != null) {
      final List<dynamic> remindersList = jsonDecode(remindersJson);
      reminders.value = remindersList.map((json) => Reminder.fromJson(json)).toList();}}
}