import 'package:flutter/material.dart';
import 'package:gps_attendance_system/core/themes/app_colors.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    required this.title,
    this.subtitle,
    super.key,
    this.onTap,
    this.leadingWidget,
    this.isUser = true,
  });

  final String title;
  final String? subtitle;
  final void Function()? onTap;
  final bool isUser;
  final Widget? leadingWidget;

  @override
  Widget build(BuildContext context) {
    double avatarRadius = MediaQuery.of(context).size.width * 0.07;
    return isUser
        ? Card(
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              focusColor: AppColors.secondary,
              hoverColor: AppColors.secondary,
              selectedColor: AppColors.secondary,
              title: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              subtitle: subtitle == null ? null : Text(subtitle ?? ''),
              leading: leadingWidget,
              onTap: onTap,
            ),
          )
        : ListTile(
            focusColor: AppColors.secondary,
            hoverColor: AppColors.secondary,
            selectedColor: AppColors.secondary,
            title: Text(title),
            leading: leadingWidget,
            onTap: onTap,
          );
  }
}
