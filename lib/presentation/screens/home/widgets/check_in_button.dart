import 'package:flutter/material.dart';
import 'package:gps_attendance_system/core/themes/app_colors.dart';

class CheckInOutButton extends StatelessWidget {
  const CheckInOutButton({
    required this.label,
    required this.color,
    required this.onPressed,
    this.borderRadius = 5.0,
    super.key,
  });

  final String label;
  final Color color;
  final VoidCallback? onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: Text(
        label,
        maxLines: 1,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }
}
