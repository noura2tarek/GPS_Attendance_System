// leave_state.dart
part of 'leaves_bloc.dart';

abstract class LeaveState {}

class LeaveInitial extends LeaveState {}

class LeaveLoading extends LeaveState {}

class LeaveLoaded extends LeaveState {
  final List<LeaveModel> leaves;
  final List<LeaveModel> allLeaves;
  final int leaveBalance;

  LeaveLoaded({
    required this.leaves,
    required this.allLeaves,
    this.leaveBalance = 25, // Default value
  });
}

class LeaveError extends LeaveState {
  final String message;

  LeaveError({required this.message});
}
