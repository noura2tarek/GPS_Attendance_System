// Role enum
import 'package:cloud_firestore/cloud_firestore.dart';

enum Role { admin, employee, manager }

class UserModel {
  final String? id;
  final String name;
  final String email;
  final String contactNumber;
  final bool isOnLeave; // for admin to track
  final Role role; // admin, employee, manager
  final String position;
  final int leaveBalance;
  final String gender; // 'male' or 'female'

  UserModel({
    required this.name,
    required this.email,
    required this.contactNumber,
    required this.role,
    required this.position,
    required this.gender,
    this.id,
    this.isOnLeave = false,
    this.leaveBalance = 25,
  });

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return UserModel(
      id: snapshot.id,
      name: data?['name'] as String,
      email: data?['email'] as String,
      contactNumber: data?['contactNumber'] as String,
      isOnLeave: data?['isOnLeave'] as bool,
      role: roleFromString(data?['role'] as String),
      position: data?['position'] as String,
      leaveBalance: data?['leaveBalance'] as int,
      gender: data?['gender'] as String? ?? 'male',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'contactNumber': contactNumber,
      'isOnLeave': isOnLeave,
      'role': stringFromRole(role),
      'position': position,
      'leaveBalance': leaveBalance,
      'gender': gender,
    };
  }

  String getAvatarImage() {
    return gender.toLowerCase() == 'male'
        ? 'assets/images/avatars/male_avatar.png'
        : 'assets/images/avatars/female_avatar.png';
  }
}

//////////////////////////
// convert role to string
String stringFromRole(Role role) {
  switch (role) {
    case Role.admin:
      return 'Admin';
    case Role.employee:
      return 'Employee';
    case Role.manager:
      return 'Manager';
  }
}

// convert string from database to role
Role roleFromString(String role) {
  switch (role) {
    case 'Admin':
      return Role.admin;
    case 'Employee':
      return Role.employee;
    case 'Manager':
      return Role.manager;
    default:
      return Role.employee;
  }
}
