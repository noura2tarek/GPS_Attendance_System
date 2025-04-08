import 'package:flutter/material.dart';
import 'package:gps_attendance_system/core/themes/app_theme.dart';

abstract class ThemeState {
  ThemeData get themeData;
}

class LightThemeState extends ThemeState {
  @override
  ThemeData get themeData => MyTheme.lightTheme;
}

class DarkThemeState extends ThemeState {
  @override
  ThemeData get themeData => MyTheme.darkTheme;
}
