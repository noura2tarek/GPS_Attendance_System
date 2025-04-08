import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gps_attendance_system/core/app_strings.dart';
import 'package:gps_attendance_system/core/models/attendance_model.dart';
import 'package:gps_attendance_system/core/services/attendance_service.dart';
import 'package:gps_attendance_system/core/services/shared_prefs_service.dart';
import 'package:gps_attendance_system/core/utils/AttendanceStatusHelper.dart';

part 'attendance_event.dart';

part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  double? companyLat;
  double? companyLng;
  final double geofenceRadius = 100;
  final now = DateTime.now();
  static final DateTime officialCheckInTime = DateTime(
    DateTime
        .now()
        .year,
    DateTime
        .now()
        .month,
    DateTime
        .now()
        .day,
    9,
  );
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AttendanceBloc() : super(AttendanceInitial()) {
    on<FetchCompanyLocation>(_fetchCompanyLocation);
    on<CheckEmployeeLocation>(_onCheckEmployeeLocation);
    on<CheckIn>(_onCheckIn);
    on<CheckOut>(_onCheckOut);
    on<FetchAttendanceCountData>(_onFetchAttendanceData);
  }

  // fetch company location event handler
  Future<void> _fetchCompanyLocation(FetchCompanyLocation event,
      Emitter<AttendanceState> emit,) async {
    try {
      final docSnapshot = await AttendanceService.fetchCompanyLocation();

      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        companyLat = data['latitude'] as double;
        companyLng = data['longitude'] as double;

        emit(CompanyLocationUpdated(companyLat!, companyLng!));
        String? userRole =
        SharedPrefsService.getData(key: AppStrings.roleKey) as String?;
        if (userRole == 'admin') {
          bool? mode =
          SharedPrefsService.getData(key: AppStrings.adminMode) as bool?;
          bool isAdminMode = mode ?? true;
          if (isAdminMode == true) {
            add(FetchAttendanceCountData());
          }
        }
      } else {
        print('Company location document does not exist');
      }
    } catch (e) {
      print('Error fetching company location: $e');
    }
  }

  Future<void> _onCheckEmployeeLocation(CheckEmployeeLocation event,
      Emitter<AttendanceState> emit,) async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        emit(EmployeeLocationPermissionDenied());
        await Geolocator.requestPermission();
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      double distance = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        companyLat!,
        companyLng!,
      );

      if (distance <= geofenceRadius) {
        bool isOnTime = now.isBefore(officialCheckInTime);
        emit(EmployeeLocationInside(checkInTime: now, isOnTime: isOnTime));
      } else {
        log('User is outside the geofence');
        emit(EmployeeLocationOutside());
      }
    } catch (e) {
      emit(EmployeeLocationError('Error checking location: $e'));
    }
  }

  // check in event handler
  Future<void> _onCheckIn(CheckIn event, Emitter<AttendanceState> emit) async {
    final user = _auth.currentUser;
    if (user == null) {
      emit(EmployeeLocationError('User not found'));
      return;
    }

    final todayDate = '${now.year}-${now.month}-${now.day}';
    final checkInTime =
        "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(
        2, '0')}";

    final status = AttendanceStatusHelper.getStatus(now);
    final docId = '${user.uid}_$todayDate';
    final data = AttendanceModel(
      userId: user.uid,
      date: todayDate,
      checkInTime: checkInTime,
      checkOutTime: null,
      // to fix error in attendance records
      status: status,
      timestamp: Timestamp.fromDate(now),
    );

    try {
      await AttendanceService.addAttendanceRecord(data, docId);
      emit(EmployeeCheckedIn(time: checkInTime));
    } catch (e) {
      emit(EmployeeLocationError('Failed to check in: $e'));
    }
  }

  // check out event handler
  Future<void> _onCheckOut(CheckOut event,
      Emitter<AttendanceState> emit,) async {
    final user = _auth.currentUser;
    if (user == null) {
      emit(EmployeeLocationError('User not found'));
      return;
    }

    final todayDate = '${now.year}-${now.month}-${now.day}';
    final checkOutTime =
        "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(
        2, '0')}";

    final attendanceDoc =
    AttendanceService.attendanceRecords.doc('${user.uid}_$todayDate');

    try {
      DocumentSnapshot doc = await attendanceDoc.get();
      String? previousCheckInTime =
      doc.exists ? (doc['checkInTime'] as String?) : null;

      await attendanceDoc.update({
        'checkOutTime': checkOutTime,
      });

      emit(EmployeeCheckedOut(
        checkOutTime: checkOutTime,
        previousCheckInTime: previousCheckInTime,
      ));
    } catch (e) {
      emit(EmployeeLocationError('Failed to check out: $e'));
    }
  }

  // Fetch attendance count data as stream handler
  Future<void> _onFetchAttendanceData(FetchAttendanceCountData event,
      Emitter<AttendanceState> emit,) async {
    await Future.delayed(const Duration(milliseconds: 200));
    emit(FetchAttendanceCountLoading());
    await emit.onEach<List<AttendanceModel>>(
      AttendanceService.getAttendanceData(),
      onData: (data) {
        final Set<String> presentUserIdsToday = {};
        final Set<String> presentUserIds = {};
        int totalAttendanceToday = 0;
        int totalEmployeesPresentNow = 0;
        for (final element in data) {
          final userId = element.userId;
          final checkInTime = element.timestamp.toDate();
          if (checkInTime.day == now.day &&
              checkInTime.month == now.month &&
              checkInTime.year == now.year) {
            presentUserIdsToday.add(userId);
          }
          if (element.checkOutTime == null && checkInTime.day == now.day &&
              checkInTime.month == now.month && checkInTime.year == now.year) {
            presentUserIds.add(userId);
          }
        }
        totalEmployeesPresentNow = presentUserIds.length;
        totalAttendanceToday = presentUserIdsToday.length;
        if (!isClosed) {
          emit(
            FetchAttendanceCountSuccess(
              totalAttendanceToday: totalAttendanceToday,
              totalEmployeesPresentNow: totalEmployeesPresentNow,
            ),
          );
        }
      },
      onError: (error, stackTrace) {
        emit(FetchAttendanceCountError(error.toString()));
      },
    );
  }
}
