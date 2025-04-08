part of 'attendance_bloc.dart';

abstract class AttendanceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CheckEmployeeLocation extends AttendanceEvent {}

class CheckIn extends AttendanceEvent {}

class CheckOut extends AttendanceEvent {}

class CompanyLocationFetched extends AttendanceEvent {
  final double lat;
  final double lng;

  CompanyLocationFetched(this.lat, this.lng);
}
class FetchAttendanceCountData extends AttendanceEvent {}
class FetchCompanyLocation extends AttendanceEvent {}

