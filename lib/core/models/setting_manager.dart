import 'package:flutter/material.dart';
import 'package:gps_attendance_system/core/app_routes.dart';

class SettingsManager {
  factory SettingsManager() {
    return _instance;
  }

  SettingsManager._internal();

  static final SettingsManager _instance = SettingsManager._internal();

  void goToProfile(BuildContext context) {
    Navigator.pop(context);
  }

  // Switch to user mode and navigate to home layout
  // For admin only.
  void switchToUserMode({
    required BuildContext context,
  }) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.homeLayoutRoute,
      (route) => false,
    );
  }

  void switchToAdminMode({
    required BuildContext context,
  }) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.adminHome,
      (route) => false,
    );
  }
}
