part of 'attendance_bloc.dart';

abstract class AttendanceState {}

class AttendanceInitial extends AttendanceState {}

class EmployeeLocationPermissionDenied extends AttendanceState {}

class EmployeeLocationInside extends AttendanceState {

  EmployeeLocationInside({required this.checkInTime, required this.isOnTime});
  final DateTime checkInTime;
  final bool isOnTime;
}

class EmployeeLocationOutside extends AttendanceState {}

class EmployeeCheckedIn extends AttendanceState {

  EmployeeCheckedIn({required this.time});
  final String time;
}

class EmployeeCheckedOut extends AttendanceState {

  EmployeeCheckedOut({required this.checkOutTime, this.previousCheckInTime});
  final String checkOutTime;
  final String? previousCheckInTime;
}

class CompanyLocationUpdated extends AttendanceState {

  CompanyLocationUpdated(this.lat, this.lng);
  final double lat;
  final double lng;
}

class EmployeeLocationError extends AttendanceState {

  EmployeeLocationError(this.message);
  final String message;
}

class FetchAttendanceCountSuccess extends AttendanceState {
  FetchAttendanceCountSuccess(
      {required this.totalAttendanceToday,
      required this.totalEmployeesPresentNow});

  final int totalAttendanceToday;
  final int totalEmployeesPresentNow;
}

class FetchAttendanceCountError extends AttendanceState {

  FetchAttendanceCountError(this.message);
  final String message;
}
class FetchAttendanceCountLoading extends AttendanceState {}
