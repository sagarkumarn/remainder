import 'package:flutter/material.dart';

class Reminder {
  final String day;
  final String id;
  final TimeOfDay time;
  final String activity;

  Reminder({
    required this.day,
    required this.id,
    required this.time,
    required this.activity,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Reminder &&
        other.day == day &&
        other.time == time &&
        other.activity == activity;
  }

  @override
  int get hashCode => day.hashCode ^ time.hashCode ^ activity.hashCode;

  Map<String, dynamic> toJson() => {
        'day': day,
        'id': id,
        'time': '${time.hour}:${time.minute}',
        'activity': activity,
      };

  factory Reminder.fromJson(Map<String, dynamic> json) {
    final timeParts = json['time'].split(':');
    final hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1]);

    return Reminder(
      day: json['day'],
      id: json['id'],
      time: TimeOfDay(hour: hour, minute: minute),
      activity: json['activity'],);}
}
