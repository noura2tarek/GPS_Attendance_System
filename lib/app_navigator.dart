import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_attendance_system/blocs/auth/auth_cubit.dart';
import 'package:gps_attendance_system/core/app_strings.dart';
import 'package:gps_attendance_system/core/services/shared_prefs_service.dart';
import 'package:gps_attendance_system/core/themes/app_colors.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/admin_home_page.dart';
import 'package:gps_attendance_system/presentation/screens/auth/login_page.dart';
import 'package:gps_attendance_system/presentation/screens/user_layout/home_layout.dart';

class AppNavigator extends StatelessWidget {
  const AppNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthStates>(
      builder: (context, state) {
        if (state is Authenticated) {
          // check user role first
          // if admin -> navigate to admin dashboard
          // else -> navigate to user home page
          // Get user role from shared prefs
          String? userRole =
              SharedPrefsService.getData(key: AppStrings.roleKey) as String?;
          log('From AppNavigator: user role saved is: $userRole');
          if (userRole == 'admin') {
            bool? mode =
                SharedPrefsService.getData(key: AppStrings.adminMode) as bool?;
            print('mode saved is $mode');
            bool isAdminMode = mode ?? true;
            if (isAdminMode == true) {
              return AdminHome();
            } else {
              return const HomeLayout();
            }
          } else {
            return const HomeLayout();
          }
        } else if (state is Unauthenticated || state is AuthLoading) {
          return const LoginPage();
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            ),
          );
        }
      },
    );
  }
}
