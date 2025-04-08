import 'package:flutter/material.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/widgets/custom_det_text.dart';

class CustomRowDetails extends StatelessWidget {
  const CustomRowDetails({
    required this.title,
    required this.subtitle,
    super.key,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        bottom: 8,
        start: 8,
        end: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomDetText(text: title),
          CustomDetText(text: subtitle),
        ],
      ),
    );
  }
}
