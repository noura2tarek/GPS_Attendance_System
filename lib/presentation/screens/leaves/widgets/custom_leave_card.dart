//-------------- Leave Card ---------------//
import 'package:flutter/material.dart';
import 'package:gps_attendance_system/core/models/leave_model.dart';

class CustomLeaveCard extends StatelessWidget {
  const CustomLeaveCard({
    required this.startDate,
    required this.endDate,
    required this.leave,
    required this.days,
    super.key,
  });

  final String startDate;
  final String endDate;
  final LeaveModel leave;
  final int days;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 12,
        ),
        title: Text(
          '$startDate - $endDate',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          leave.status,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: leave.status == 'Approved'
                ? Colors.green
                : leave.status == 'Pending'
                    ? Colors.orange
                    : Colors.red,
          ),
        ),
        trailing: Text(
          '$days Day${days != 1 ? 's' : ''}',
          textDirection: TextDirection.ltr,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
