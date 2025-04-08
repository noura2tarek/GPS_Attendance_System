// leave_event.dart
part of 'leaves_bloc.dart';

abstract class LeaveEvent {}

class FetchLeaves extends LeaveEvent {}

class FilterLeaves extends LeaveEvent {
  final String filter;

  FilterLeaves(this.filter);
}

class LeavesUpdated extends LeaveEvent {
  final List<LeaveModel> leaves;

  LeavesUpdated(this.leaves);
}

class FetchLeaveBalance extends LeaveEvent {}
