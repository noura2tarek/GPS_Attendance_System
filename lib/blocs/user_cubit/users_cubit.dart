import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_attendance_system/core/app_strings.dart';
import 'package:gps_attendance_system/core/models/user_model.dart';
import 'package:gps_attendance_system/core/services/shared_prefs_service.dart';
import 'package:gps_attendance_system/core/services/user_services.dart';
import 'package:meta/meta.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit() : super(UsersInitial());

  // static method to get users cubit instance
  static UsersCubit get(BuildContext context) => BlocProvider.of(context);

  // filtered employees list
  List<UserModel> employees = [];

  // filtered managers list
  List<UserModel> managers = [];

  // ALL users list
  List<UserModel> users = [];

  // Get all users method
  Future<void> getUsers() async {
    try {
      emit(UsersLoading());
      await Future.delayed(const Duration(milliseconds: 500));

      // Update gender for all users first
      await UserService.updateAllUsersGender();

      users = await UserService.getAllUsers();

      // Filter employees & managers
      for (final user in users) {
        if (user.role == Role.employee) {
          employees.add(user);
        } else if (user.role == Role.manager) {
          managers.add(user);
        }
      }
      emit(
        GetUsersSuccess(
          users: users,
        ),
      );
    } catch (e) {
      emit(UsersErrors(e.toString()));
    }
  }

  UserModel? adminData;

  // Get current admin data
  Future<UserModel?> getAdminData() async {
    String? uid = SharedPrefsService.getData(key: AppStrings.id) as String?;
    log('user id saved is $uid');
    uid ??= UserService.authInstance.currentUser!.uid;
    UserModel? admin = await UserService.getUserData(uid);
    if (admin == null) return null;
    if (admin.role != Role.admin) return null;
    adminData = admin;
    emit(GetAdminDataSuccess(adminData!));
    print('admin name data is: ${adminData?.name}');
    return adminData;
  }
}
