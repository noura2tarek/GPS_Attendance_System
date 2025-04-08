import 'package:flutter/material.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/widgets/custom_column.dart';

class CustomRowSections extends StatelessWidget {
  const CustomRowSections({
    required this.text1,
    required this.text2,
    required this.text3,
    required this.text4,
    required this.text5,
    required this.text6,
    required this.text7,
    required this.text8,
    super.key,
  });

  final String text1;
  final String text2;
  final String text3;
  final String text4;
  final String text5;
  final String text6;
  final String text7;
  final String text8;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: 8, start: 8, end: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomColumn(
            text1: text1,
            text2: text2,
            text3: text3,
            text4: text4,
          ),
          CustomColumn(
            text1: text5,
            text2: text6,
            text3: text7,
            text4: text8,
          ),
        ],
      ),
    );
  }
}
