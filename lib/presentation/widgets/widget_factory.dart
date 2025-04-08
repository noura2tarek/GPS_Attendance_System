import 'package:flutter/material.dart';
import 'package:gps_attendance_system/presentation/widgets/language_switcher.dart';
import 'package:gps_attendance_system/presentation/widgets/theme_switcher.dart';

class WidgetFactory {
  static Widget createWidget(String type) {
    switch (type) {
      case 'language':
        return const LanguageSwitcher();
      case 'theme':
        return const ThemeSwitcher();
      default:
        throw Exception('Unknown widget type');
    }
  }
}