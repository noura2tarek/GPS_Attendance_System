import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_attendance_system/blocs/leaves_admin/leaves_cubit.dart';
import 'package:gps_attendance_system/core/models/leave_model.dart';
import 'package:gps_attendance_system/core/models/user_model.dart';
import 'package:gps_attendance_system/core/services/user_services.dart';
import 'package:gps_attendance_system/l10n/l10n.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/widgets/custom_det_text.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/widgets/custom_det_title.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/widgets/custom_row_sections.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/widgets/my_divider.dart';
import 'package:gps_attendance_system/presentation/widgets/snakbar_widget.dart';
import 'package:intl/intl.dart' as intl;

class PendingLeaveDetails extends StatefulWidget {
  const PendingLeaveDetails({required this.model, super.key});

  final LeaveModel model;

  @override
  State<PendingLeaveDetails> createState() => _PendingLeaveDetailsState();
}

class _PendingLeaveDetailsState extends State<PendingLeaveDetails> {
  UserModel? _userModel;

  void _getUserData() async {
    _userModel = await UserService.getUserData(widget.model.userId);
    setState(() {});
  }

  @override
  void initState() {
    _getUserData();
    super.initState();
  }

  final dateFormat = intl.DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    final startDate = dateFormat.format(widget.model.startDate.toDate());
    final endDate = dateFormat.format(widget.model.endDate.toDate());
    int noOfDays = widget.model.endDate
        .toDate()
        .difference(widget.model.startDate.toDate())
        .inDays;
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context).leaveDetails)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocListener<LeavesCubit, LeavesState>(
          listener: (context, state) {
            if (state is LeaveApproved) {
              CustomSnackBar.show(
                context,
                AppLocalizations.of(context).leaveApprovedSuccess,
                color: chooseSnackBarColor(ToastStates.SUCCESS),
              );
              Navigator.pop(context);
            } else if (state is LeaveRejected) {
              CustomSnackBar.show(
                context,
                AppLocalizations.of(context).leaveRejectedSuccess,
                color: chooseSnackBarColor(ToastStates.SUCCESS),
              );
              Navigator.pop(context);
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 8),
                child: CustomDetTitle(
                  text: AppLocalizations.of(context).userDetails,
                ),
              ),
              // --- User Details
              CustomRowSections(
                text1: '${AppLocalizations.of(context).leaveBalance}:',
                text2: '${AppLocalizations.of(context).name}:',
                text3: '${AppLocalizations.of(context).role}:',
                text4: '${AppLocalizations.of(context).email}:',
                text5: _userModel?.leaveBalance.toString() ?? '',
                text6: _userModel?.name ?? '',
                text7: stringFromRole(_userModel?.role ?? Role.admin),
                text8: _userModel?.email ?? '',
              ),
              //---- End of User Details
              const MyDivider(),
              CustomDetTitle(
                text: AppLocalizations.of(context).leaveDetails,
              ),
              //--- Leave Details
              CustomRowSections(
                text1: '${AppLocalizations.of(context).leaveTitle}:',
                text2: '${AppLocalizations.of(context).leaveType}:',
                text3: '${AppLocalizations.of(context).reason}:',
                text4: '${AppLocalizations.of(context).status}:',
                text5: widget.model.title,
                text6: widget.model.leaveType,
                text7: widget.model.reason,
                text8: widget.model.status,
              ),
              // Start & end date
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  bottom: 8,
                  start: 8,
                  end: 8,
                ),
                child: Row(
                  children: [
                    CustomDetText(
                      text: startDate,
                    ),
                    CustomDetText(
                      text: AppLocalizations.of(context).to,
                    ),
                    CustomDetText(
                      text: endDate,
                    ),
                    const Spacer(),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: CustomDetText(
                        text: '$noOfDays Day${noOfDays != 1 ? 's' : ''}',
                      ),
                    ),
                  ],
                ),
              ),
              const MyDivider(),
              const Spacer(),
              //---- Approve and reject buttons ----//
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Approve button
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            const WidgetStatePropertyAll(Colors.green),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: () {
                        LeavesCubit.get(context).acceptLeave(widget.model);
                      },
                      child: Text(AppLocalizations.of(context).approve),
                    ),
                  ),
                  // Reject button
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: const WidgetStatePropertyAll(
                          Colors.red,
                        ),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: () {
                        LeavesCubit.get(context).rejectLeave(widget.model);
                      },
                      child: Text(AppLocalizations.of(context).reject),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

////////////////////////////////////
