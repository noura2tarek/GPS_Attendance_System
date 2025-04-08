import 'package:flutter/material.dart';

import 'package:gps_attendance_system/core/themes/app_colors.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({

    required this.labelText,
    required this.controller,
    required this.validator,
    required this.prefixIcon,

    super.key,
    this.suffixIcon,
    this.keyboardType,
    this.obscureText = false,
    this.suffixPressed,
    this.hintText,
  });

  final String labelText;
  final String? hintText;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final void Function()? suffixPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        cursorColor: AppColors.primary,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          prefixIcon: Icon(
            prefixIcon,
            color: AppColors.fourthColor,
          ),
          suffixIcon: suffixIcon != null
              ? IconButton(
                  onPressed: suffixPressed,
                  icon: Icon(
                    suffixIcon,
                    color: AppColors.fourthColor,
                  ),
                )
              : null,

          contentPadding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
        ),
        obscureText: obscureText,
        controller: controller,
        validator: validator,
      ),
    );
  }
}
