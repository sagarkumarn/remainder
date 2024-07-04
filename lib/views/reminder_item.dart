import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/reminder_controller.dart';
import '../models/reminder.dart';

class ReminderItem extends StatefulWidget {
  const ReminderItem({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ReminderItemState createState() => _ReminderItemState();
}

class _ReminderItemState extends State<ReminderItem> {
  final ReminderController controller = Get.find();
  String selectedDay = 'Monday';
  TimeOfDay selectedTime = TimeOfDay.now();
  String selectedActivity = 'Wake up';

  final List<String> days = [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday', 'Everyday'
  ];

  final List<String> activities = [
    'Wake up', 'Go to gym', 'Breakfast', 'Meetings', 'Lunch', 'Quick nap', 'Go to library', 'Dinner', 'Go to sleep'
  ];

  @override
  void initState() {
    super.initState();
    selectedDay = days[DateTime.now().weekday - 1]; 
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                
                contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
              ),
              value: selectedDay,
              onChanged: (newValue) {
                setState(() {
                  selectedDay = newValue!;
                });
              },
              items: days.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green
              ),
              onPressed: () async {
                TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: selectedTime,
                );
                if (picked != null && picked != selectedTime) {
                  setState(() {
                    selectedTime = picked;
                  });
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Selected Time:  '),
                  Text(controller.formatTime(selectedTime.hour, selectedTime.minute)),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
              ),
              value: selectedActivity,
              onChanged: (newValue) {
                setState(() {
                  selectedActivity = newValue!;
                });
              },
              items: activities.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                controller.addReminder(Reminder(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  day: selectedDay,
                  time: selectedTime,
                  activity: selectedActivity,
                ),context);
               
              },
              child: const Text('Add Reminder'),
            ),
          ],
        ),
      ),
    );
  }
}
