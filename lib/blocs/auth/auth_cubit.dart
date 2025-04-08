import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_attendance_system/core/app_strings.dart';
import 'package:gps_attendance_system/core/models/user_model.dart';
import 'package:gps_attendance_system/core/services/shared_prefs_service.dart';
import 'package:gps_attendance_system/core/services/user_services.dart';
import 'package:meta/meta.dart';

part 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitial());

  //-- init method --//
  void init() {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      emit(Authenticated(userId: currentUser.uid));
    } else {
      emit(Unauthenticated());
    }
  }

  // get instance of cubit
  static AuthCubit get(BuildContext context) => BlocProvider.of(context);

  //-- Login method --//
  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      // login using firebase auth
      final user = await UserService.signInWithEmailAndPassword(
        email,
        password,
      );
      if (user != null) {
        // save token or id in shared prefs
        await SharedPrefsService.saveData(
          key: AppStrings.id,
          value: user.uid,
        );
        UserModel? userModel = await UserService.getUserData(user.uid);
        if (userModel != null) {
          // save user role in shared prefs
          await SharedPrefsService.saveData(
            key: AppStrings.roleKey,
            value: userModel.role == Role.admin ? 'admin' : 'user',
          );
          emit(Authenticated(userId: user.uid, userRole: userModel.role));
        }
      } else {
        emit(Unauthenticated());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(AuthError(message: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(AuthError(message: 'Wrong password provided for that user.'));
      } else if (e.code == 'invalid-email') {
        emit(AuthError(message: 'The email address is not valid.'));
      } else {
        emit(AuthError(message: 'An error occurred'));
      }
    } catch (e) {
      emit(AuthError(message: 'An error occurred'));
    }
  }

//-- Add user method --//
  Future<void> addUser({
    required String email,
    required String password,
    required UserModel userModel,
  }) async {
    emit(AuthLoading());
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String uid = credential.user!.uid;
      // save user data in firebase
      UserModel newUser = UserModel(
        id: uid,
        name: userModel.name,
        email: email,
        role: userModel.role,
        contactNumber: userModel.contactNumber,
        isOnLeave: userModel.isOnLeave,
        position: userModel.position,
        gender: userModel.gender,
      );
      await UserService.addUser(uid, newUser);
      emit(AccountCreated());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        emit(AuthError(message: 'The account already exists for that email.'));
      }
    } catch (e) {
      emit(AuthError(message: 'There was an error creating the account'));
    }
  }

  // Logout method
  Future<void> logout() async {
    await UserService.signOut();
    // delete user id & role of logged in user
    await SharedPrefsService.clearStringData(
      key: AppStrings.id,
    );
    await SharedPrefsService.clearStringData(
      key: AppStrings.roleKey,
    );

    emit(Unauthenticated());
  }
}
