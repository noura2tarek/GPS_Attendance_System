import 'package:flutter/material.dart';
import 'package:gps_attendance_system/core/app_routes.dart';
import 'package:gps_attendance_system/core/models/leave_model.dart';
import 'package:gps_attendance_system/core/themes/app_colors.dart';
import 'package:gps_attendance_system/l10n/l10n.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/widgets/custom_det_text.dart';

class LeaveCard extends StatelessWidget {
  const LeaveCard({
    required this.startDate,
    required this.endDate,
    required this.leave,
    required this.noOfDays,
    super.key,
    this.isTabbed = true,
  });

  final String startDate;
  final String endDate;
  final LeaveModel leave;
  final int noOfDays;
  final bool isTabbed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // on tab: go to leave details
      onTap: isTabbed
          ? () {
              Navigator.pushNamed(
                context,
                arguments: leave,
                AppRoutes.pendingLeaveDetails,
              );
            }
          : null,
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //-------- Title and status row ------------//
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    leave.title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: leave.status == 'Approved'
                          ? Colors.green.withValues(alpha: 0.2)
                          : leave.status == 'Rejected'
                              ? Colors.red.withValues(alpha: 0.2)
                              : AppColors.lightOrangeColor,
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Text(
                      leave.status,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: leave.status == 'Approved'
                            ? Colors.green
                            : leave.status == 'Rejected'
                                ? Colors.red
                                : Colors.orange,
                      ),
                    ),
                  ),
                ],
              ),
              // divider
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Divider(
                  height: 3,
                ),
              ),
              // Start & end date
              Row(
                children: [
                  CustomDetText(
                    text: startDate,
                    fontWeight: FontWeight.normal,
                  ),
                  CustomDetText(
                    text: AppLocalizations.of(context).to,
                    fontWeight: FontWeight.normal,
                  ),
                  CustomDetText(
                    text: endDate,
                    fontWeight: FontWeight.normal,
                  ),
                  const Spacer(),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: CustomDetText(
                      textColor: Colors.grey,
                      fontSize: 14,
                      text: '$noOfDays Day${noOfDays != 1 ? 's' : ''}',
                    ),
                  ),
                ],
              ),
              // leave type
              Text(
                leave.leaveType,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.black2Color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
