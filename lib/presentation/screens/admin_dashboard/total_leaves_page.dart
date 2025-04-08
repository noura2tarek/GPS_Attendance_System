import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_attendance_system/blocs/leaves_admin/leaves_cubit.dart';
import 'package:gps_attendance_system/core/models/leave_model.dart';
import 'package:gps_attendance_system/l10n/l10n.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/pending_approvals_page.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/widgets/leave_card.dart';
import 'package:gps_attendance_system/presentation/widgets/snakbar_widget.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

// dummy leaves
List<LeaveModel> dummyLeaves = [
  LeaveModel(
    title: 'Dummy Casual Leave',
    leaveType: 'Casual Leave',
    contactNumber: '01062197942',
    startDate: Timestamp.fromDate(DateTime.now()),
    endDate: Timestamp.fromDate(DateTime.now()),
    reason: 'this reason',
    userId: FirebaseAuth.instance.currentUser!.uid,
    id: '4444',
  ),
  LeaveModel(
    title: ' Dummy Casual Leave',
    leaveType: 'Casual Leave',
    contactNumber: '01062197942',
    startDate: Timestamp.fromDate(DateTime.now()),
    endDate: Timestamp.fromDate(DateTime.now()),
    reason: 'this reason',
    userId: FirebaseAuth.instance.currentUser!.uid,
    id: '4444',
  ),
];

class TotalLeavesPage extends StatelessWidget {
  TotalLeavesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(AppLocalizations.of(context).totalTLeaves),
      ),
      body: BlocBuilder<LeavesCubit, LeavesState>(
        builder: (context, state) {
          if (state is LeavesError) {
            CustomSnackBar.show(
              context,
              state.message,
              color: chooseSnackBarColor(ToastStates.ERROR),
            );
          }

          // Date formatter
          final dateFormat = DateFormat('yyyy-MM-dd');

          if (state is LeavesLoaded || state is GetLeavesLoading) {
            List<LeaveModel> allLeaves = [];
            if (state is LeavesLoaded) {
              allLeaves = state.totalLeaves;
            }
            if (allLeaves.isNotEmpty || state is GetLeavesLoading) {
              return Skeletonizer(
                enabled: state is GetLeavesLoading,
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(top: 16),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final leave = allLeaves.isEmpty
                          ? dummyPendingLeaves[index]
                          : allLeaves[index];
                      final startDate =
                          dateFormat.format(leave.startDate.toDate());
                      final endDate = dateFormat.format(leave.endDate.toDate());
                      int noOfDays = leave.endDate
                          .toDate()
                          .difference(leave.startDate.toDate())
                          .inDays;
                      return LeaveCard(
                        isTabbed: false,
                        startDate: startDate,
                        endDate: endDate,
                        leave: leave,
                        noOfDays: noOfDays,
                      );
                    },
                    itemCount: allLeaves.isEmpty
                        ? dummyPendingLeaves.length
                        : allLeaves.length,
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 13,
                    ),
                  ),
                ),
              );
            } else {
              Center(
                child: Text(AppLocalizations.of(context).noLeaves),
              );
            }
          } else {
            return const SizedBox();
          }

          return const SizedBox();
        },
      ),
    );
  }
}
