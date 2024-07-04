import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/reminder.dart';
import '../controllers/reminder_controller.dart';

class ReminderListItem extends StatelessWidget {
  final Reminder reminder;
  final int index;
  final ReminderController controller = Get.find();

  ReminderListItem({required this.reminder, required this.index});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(reminder.id.toString()),
      onDismissed: (direction) {
        controller.removeReminder(reminder.id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${reminder.activity} dismissed')),
        );
      },
      background: Container(color: Colors.red),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.shade300, // Divider color
              width: 1.0, // Divider thickness
            ),
          ),
        ),
        child: ListTile(
          title: Text('${reminder.day} - ${reminder.activity}'),
          subtitle: Text(reminder.time.format(context)),
        ),
      ),
    );
  }
}
