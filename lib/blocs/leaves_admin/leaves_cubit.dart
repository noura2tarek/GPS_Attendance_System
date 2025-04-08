import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_attendance_system/core/models/leave_model.dart';
import 'package:gps_attendance_system/core/models/user_model.dart';
import 'package:gps_attendance_system/core/services/leave_service.dart';
import 'package:meta/meta.dart';

part 'leaves_state.dart';

class LeavesCubit extends Cubit<LeavesState> {
  LeavesCubit() : super(LeavesInitial());

  // static method to get cubit object
  static LeavesCubit get(BuildContext context) => BlocProvider.of(context);

  StreamSubscription<List<LeaveModel>>? _leavesSubscription;

  // Get all leaves from leaves service
  List<LeaveModel> allLeaves = [];
  List<LeaveModel> pendingLeaves = [];
  List<LeaveModel> approvedLeaves = [];
  List<LeaveModel> rejectedLeaves = [];

  // Get all leaves method (stream)
  void getLeaves() {
    emit(GetLeavesLoading());
    try {
      _leavesSubscription = LeaveService.getAllLeavesStream().listen((leaves) {
        allLeaves = leaves;
        pendingLeaves =
            allLeaves.where((leave) => leave.status == 'Pending').toList();
        approvedLeaves =
            allLeaves.where((leave) => leave.status == 'Approved').toList();
        rejectedLeaves =
            allLeaves.where((leave) => leave.status == 'Rejected').toList();
        if (!isClosed) {
          emit(
            LeavesLoaded(
              totalLeaves: allLeaves,
              pendingLeaves: pendingLeaves,
              approvedLeaves: approvedLeaves,
              rejectedLeaves: rejectedLeaves,
            ),
          );
        }
      });
    } catch (e) {
      emit(LeavesError(message: e.toString()));
    }
  }

  // Accept a leave
  Future<void> acceptLeave(LeaveModel leave) async {
    try {
      await LeaveService.approveLeave(leave);
      emit(LeaveApproved());
      getLeaves();
    } catch (e) {
      emit(LeavesError(message: e.toString()));
    }
  }

  // Reject a leave
  Future<void> rejectLeave(LeaveModel leave) async {
    try {
      await LeaveService.rejectLeave(leave);
      emit(LeaveRejected());
      getLeaves();
    } catch (e) {
      emit(LeavesError(message: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _leavesSubscription?.cancel();
    return super.close();
  }
}
