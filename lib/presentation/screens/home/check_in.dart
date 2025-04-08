import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_attendance_system/blocs/attendance/attendance_bloc.dart';
import 'package:gps_attendance_system/l10n/l10n.dart';
import 'package:gps_attendance_system/presentation/screens/home/widgets/check_in_button.dart';
import 'package:gps_attendance_system/presentation/screens/home/widgets/company_location.dart';
import 'package:gps_attendance_system/presentation/screens/home/widgets/details_card.dart';

class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  @override
  void initState() {
    super.initState();
    context.read<AttendanceBloc>().add(CheckEmployeeLocation());
  }

  @override
  Widget build(BuildContext context) {
    bool isInside = false;
    bool hasCheckedIn = false;
    bool hasCheckedOut = false;
    String checkInTime = '--:--';
    String checkOutTime = '--:--';
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: BlocBuilder<AttendanceBloc, AttendanceState>(
            builder: (context, state) {
              if (state is EmployeeLocationInside) {
                isInside = true;
                hasCheckedIn = false;
                hasCheckedOut = false;
                checkInTime = '--:--';
                checkOutTime = '--:--';
              } else if (state is EmployeeCheckedIn) {
                hasCheckedIn = true;
                checkInTime = state.time;
              } else if (state is EmployeeCheckedOut) {
                hasCheckedOut = true;
                checkOutTime = state.checkOutTime;
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      //-- Check In Button
                      Expanded(
                        child: CheckInOutButton(
                          label: AppLocalizations.of(context).checkIn,
                          color: isInside && !hasCheckedIn
                              ? const Color(0XFF2563EB)
                              : Colors.black12,
                          onPressed: isInside && !hasCheckedIn
                              ? () =>
                                  context.read<AttendanceBloc>().add(CheckIn())
                              : null,
                        ),
                      ),
                      const SizedBox(
                        width: 9,
                      ),
                      //-- Check Out Button
                      Expanded(
                        child: CheckInOutButton(
                          label: AppLocalizations.of(context).checkOut,
                          color: hasCheckedIn
                              ? const Color(0XFF203546)
                              : const Color(0xff50B3C8),
                          onPressed: hasCheckedIn && !hasCheckedOut
                              ? () =>
                                  context.read<AttendanceBloc>().add(CheckOut())
                              : null,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    AppLocalizations.of(context).todayAtt,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: DetailsCard(
                          title: AppLocalizations.of(context).checkInTime,
                          subtitle: checkInTime,
                          icon: Icons.login,
                          iconColor: const Color(0xff203546),
                        ),
                      ),
                      Expanded(
                        child: DetailsCard(
                          title: AppLocalizations.of(context).checkOutTime,
                          subtitle: checkOutTime,
                          icon: Icons.logout,
                          iconColor: const Color(0xff203546),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const CompanyLocation(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
