import 'package:flutter/material.dart';
import 'package:gps_attendance_system/core/themes/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.text,
    required this.onPressed,
    super.key,
    this.backgroundColor = AppColors.primary,
    this.opacity = 0.8,
    this.isLoading = false,
  });

  final String text;
  final bool isLoading;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: isLoading
          ? const CircularProgressIndicator(
              color: AppColors.whiteColor,
            )
          : Text(
              text,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
    );
  }
}
