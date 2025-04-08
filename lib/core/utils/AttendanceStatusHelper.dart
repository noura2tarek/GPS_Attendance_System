import 'package:flutter/material.dart';

class AttendanceStatusHelper {
  static const TimeOfDay earlyLimit = TimeOfDay(hour: 9, minute: 0);
  static const TimeOfDay onTimeStart = TimeOfDay(hour: 9, minute: 45);
  static const TimeOfDay onTimeEnd = TimeOfDay(hour: 10, minute: 15);
  static const TimeOfDay lateLimit = TimeOfDay(hour: 11, minute: 0);

  static String getStatus(DateTime checkInTime) {
    final time = TimeOfDay.fromDateTime(checkInTime);

    if (_isBefore(time, earlyLimit)) return "Out of Bounds";
    if (_isBefore(time, onTimeStart)) return "Early";
    if (_isBetween(time, onTimeStart, onTimeEnd)) return "On Time";
    if (_isBefore(time, lateLimit)) return "Late";

    return "Out of Bounds";
  }

  static bool _isBefore(TimeOfDay t1, TimeOfDay t2) {
    return t1.hour < t2.hour || (t1.hour == t2.hour && t1.minute < t2.minute);
  }

  static bool _isBetween(TimeOfDay check, TimeOfDay start, TimeOfDay end) {
    return !_isBefore(check, start) && _isBefore(check, end);
  }
}