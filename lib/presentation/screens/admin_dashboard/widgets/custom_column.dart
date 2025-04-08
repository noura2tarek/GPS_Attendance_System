import 'package:flutter/material.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/widgets/custom_det_text.dart';

class CustomColumn extends StatelessWidget {
  const CustomColumn({
    required this.text1,
    required this.text2,
    required this.text3,
    required this.text4,
    super.key,
  });

  final String text1;
  final String text2;
  final String text3;
  final String text4;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomDetText(text: text1),
        CustomDetText(text: text2),
        CustomDetText(text: text3),
        CustomDetText(text: text4),
      ],
    );
  }
}
