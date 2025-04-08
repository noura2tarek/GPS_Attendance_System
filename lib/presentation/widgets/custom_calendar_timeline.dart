import 'package:flutter/material.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:gps_attendance_system/core/themes/app_colors.dart';

class CustomCalendarTimeline extends StatefulWidget {
  const CustomCalendarTimeline({required this.onDateSelected, super.key});

  final void Function(DateTime) onDateSelected;

  @override
  State<CustomCalendarTimeline> createState() => _CustomCalendarTimelineState();
}

class _CustomCalendarTimelineState extends State<CustomCalendarTimeline> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return CalendarTimeline(
      initialDate: selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime(2030, 12, 31),
      onDateSelected: (date) {
        setState(() => selectedDate = date);
        widget.onDateSelected(date);
      },
      leftMargin: 20,
      monthColor: Colors.blueGrey,
      dayColor: AppColors.primary,
      activeDayColor: Colors.white,
      activeBackgroundDayColor: AppColors.secondary,
      dotColor: Colors.white,
      locale: 'en',
      selectableDayPredicate: (date) => true,
    );
  }
}
