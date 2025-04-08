import 'package:flutter/material.dart';

class AttendanceHelper {
  static String getAttendanceStatus(String checkInTime) {
    TimeOfDay checkIn = _parseTime(checkInTime);

    const earlyLimit = TimeOfDay(hour: 9, minute: 0);
    const onTimeStart = TimeOfDay(hour: 9, minute: 45);
    const onTimeEnd = TimeOfDay(hour: 10, minute: 15);
    const lateLimit = TimeOfDay(hour: 11, minute: 0);

    if (_isBefore(checkIn, earlyLimit)) return 'Out of Bounds';
    if (_isBefore(checkIn, onTimeStart)) return 'Early';
    if (_isBetween(checkIn, onTimeStart, onTimeEnd)) return 'On Time';
    if (_isBefore(checkIn, lateLimit)) return 'Late';

    return 'Out of Bounds';
  }

  static Color getStatusColor(String status) {
    switch (status) {
      case 'On Time':
        return Colors.green;
      case 'Late':
        return Colors.red;
      case 'Early':
        return Colors.orange;
      case 'Out of Bounds':
        return Colors.grey;
      default:
        return Colors.black;
    }
  }

  static TimeOfDay _parseTime(String time) {
    final parts = time.split(' ');
    final timeParts = parts[0].split(':');

    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);

    if (parts[1] == 'pm' && hour != 12) hour += 12;
    if (parts[1] == 'am' && hour == 12) hour = 0;

    return TimeOfDay(hour: hour, minute: minute);
  }

  static bool _isBefore(TimeOfDay t1, TimeOfDay t2) {
    return t1.hour < t2.hour || (t1.hour == t2.hour && t1.minute < t2.minute);
  }

  static bool _isBetween(TimeOfDay check, TimeOfDay start, TimeOfDay end) {
    return !_isBefore(check, start) && _isBefore(check, end);
  }
}
