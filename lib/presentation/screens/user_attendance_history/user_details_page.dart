import 'package:flutter/material.dart';
import 'package:gps_attendance_system/core/models/attendance_model.dart';
import 'package:gps_attendance_system/core/models/user_model.dart';
import 'package:gps_attendance_system/core/services/attendance_service.dart';
import 'package:gps_attendance_system/core/utils/attendance_helper.dart';
import 'package:gps_attendance_system/l10n/l10n.dart';
import 'package:gps_attendance_system/presentation/widgets/custom_calendar_timeline.dart';
import 'package:gps_attendance_system/presentation/widgets/user_avatar.dart';
import 'package:intl/intl.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({required this.userModel, super.key});

  final UserModel userModel;

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  DateTime selectedDate = DateTime.now();

  Stream<List<AttendanceModel>> fetchAttendanceRecords() {
    String selectedDateString = DateFormat('yyyy-M-d').format(selectedDate);

    return AttendanceService.attendanceRecords
        .where('userId', isEqualTo: widget.userModel.id)
        .where('date', isEqualTo: selectedDateString)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => AttendanceModel.fromFirestore(doc))
              .toList(),
        );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Text('${widget.userModel.name} Attendance')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          children: [
            // User Info Card
            Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    UserAvatar(
                      imagePath: widget.userModel.getAvatarImage(),
                      radius: 30,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.userModel.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.userModel.position,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.userModel.email,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // -- Calender time line
            CustomCalendarTimeline(
              onDateSelected: (date) {
                setState(() => selectedDate = date);
              },
            ),
            const SizedBox(height: 15),
            //-- Attendance Records List As stream --//
            Expanded(
              child: StreamBuilder<List<AttendanceModel>>(
                stream: fetchAttendanceRecords(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  final attendanceRecords = snapshot.data!;
                  if (attendanceRecords.isEmpty) {
                    return Center(
                      child: Text(
                        AppLocalizations.of(context).noAttendanceRecordsFound,
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: attendanceRecords.length,
                    itemBuilder: (context, index) {
                      final record = attendanceRecords[index];
                      DateTime date = DateFormat('yyyy-M-d').parse(record.date);
                      String formattedDate =
                          DateFormat('yyyy-M-d').format(date);
                      String status = record.status;
                      Color statusColor =
                          AttendanceHelper.getStatusColor(status);

                      return Card(
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          title: Text(
                            formattedDate,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Check in time row
                              Row(
                                children: [
                                  const Icon(Icons.login, color: Colors.green),
                                  const SizedBox(width: 5),
                                  Text(
                                      '${AppLocalizations.of(context).checkIn} ${record.checkInTime}'),
                                ],
                              ),
                              // Check out time row
                              Row(
                                children: [
                                  if (record.checkOutTime != null)
                                    const Icon(
                                      Icons.logout,
                                      color: Colors.red,
                                    )
                                  else
                                    const Icon(Icons.verified_user_outlined),
                                  const SizedBox(width: 5),
                                  if (record.checkOutTime != null)
                                    Text(
                                        '${AppLocalizations.of(context).checkOut} ${record.checkOutTime}')
                                  else
                                    const Text(
                                      'Present',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.orange,
                                      ),
                                    ),
                                ],
                              ),
                              //-- Status Row --//
                              Row(
                                children: [
                                  Icon(Icons.info, color: statusColor),
                                  const SizedBox(width: 5),
                                  Text(
                                    status,
                                    style: TextStyle(
                                      color: statusColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
