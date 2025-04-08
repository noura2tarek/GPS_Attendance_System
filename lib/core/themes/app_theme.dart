import 'package:flutter/material.dart';
import 'package:gps_attendance_system/core/themes/app_colors.dart';

class MyTheme {
  static ThemeData createTheme({
    required Brightness brightness,
    required Color primaryColor,
    required Color scaffoldBackgroundColor,
    required Color selectedItemColor,
    required Color unselectedItemColor,
    required Color iconColor,
    required Color textColor,
    required Color cardColor,
    required Color appBarTextColor,
    required Color progressIndicatorColor,
    required Color floatingActionButtonColor,
  }) {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        elevation: 0.5,
        centerTitle: true,
        iconTheme: IconThemeData(color: iconColor),
        titleTextStyle: TextStyle(
          color: appBarTextColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: selectedItemColor,
        unselectedItemColor: unselectedItemColor,
      ),
      primaryColorLight: primaryColor,
      useMaterial3: true,
      dropdownMenuTheme: DropdownMenuThemeData(
        textStyle: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
        menuStyle: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(scaffoldBackgroundColor),
          surfaceTintColor: WidgetStatePropertyAll(scaffoldBackgroundColor),
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(color: textColor),
          labelStyle: TextStyle(color: textColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.thirdMintGreen),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.thirdMintGreen),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.fifthColor),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary.withValues(alpha: 0.8),
          foregroundColor: AppColors.whiteColor,
          shadowColor: AppColors.secondary,
          elevation: 1.4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 1.5,
        backgroundColor: floatingActionButtonColor,
        foregroundColor: AppColors.whiteColor,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: progressIndicatorColor,
      ),
      listTileTheme: ListTileThemeData(
        textColor: textColor,
        iconColor: iconColor,
      ),
      cardTheme: CardTheme(
        color: cardColor,
        surfaceTintColor: AppColors.whiteColor,
        elevation: 1.5,
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: primaryColor,
        disabledColor: primaryColor.withValues(alpha: 0.5),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: textColor),
        labelStyle: TextStyle(color: textColor),
        errorStyle: const TextStyle(fontWeight: FontWeight.bold),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.thirdMintGreen),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.thirdMintGreen),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.thirdMintGreen),
        ),
      ),
      brightness: brightness,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: brightness,
      ),
      fontFamily: 'Lora',
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: progressIndicatorColor,
          textStyle: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: textColor),
        bodyMedium: TextStyle(color: textColor),
        bodySmall: TextStyle(color: textColor),
      ),
    );
  }

  static ThemeData get lightTheme => createTheme(
    progressIndicatorColor: AppColors.primary,
    floatingActionButtonColor: AppColors.secondary,
    cardColor: AppColors.grey200Color,
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.whiteColor,
    selectedItemColor: AppColors.primary,
    unselectedItemColor: AppColors.secondary,
    iconColor: AppColors.secondary,
    textColor: AppColors.blackColor,
    appBarTextColor: AppColors.whiteColor,
  );

  static ThemeData get darkTheme => createTheme(
    brightness: Brightness.dark,
    floatingActionButtonColor: AppColors.secondary.withValues(alpha: 0.7),
    cardColor: AppColors.fifthColor.withValues(alpha: 0.9),
    progressIndicatorColor: AppColors.whiteColor,
    primaryColor: AppColors.fifthColor,
    scaffoldBackgroundColor: AppColors.blackColor,
    selectedItemColor: AppColors.secondary,
    unselectedItemColor: AppColors.whiteColor,
    iconColor: AppColors.thirdMintGreen,
    textColor: AppColors.whiteColor,
    appBarTextColor: AppColors.whiteColor,
  );
}
