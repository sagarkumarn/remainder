import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/reminder_controller.dart';
import 'reminder_item.dart';
import 'reminder_list_item.dart';

class ReminderView extends StatelessWidget {
  final ReminderController controller = Get.put(ReminderController());

  ReminderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminder App'),
      ),
      body: Column(
        children: [
          const ReminderItem(),
          Expanded(
            child: Obx(() => ListView.builder(
              padding: const EdgeInsets.only(left: 10,right: 10),
              itemCount: controller.reminders.length,
              itemBuilder: (context, index) {
                final reminder = controller.reminders[index];
                return ReminderListItem(reminder: reminder, index: index);
              },
            )),
          ),
        ],
      ),
    );
  }
}
