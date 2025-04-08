import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceModel {
  AttendanceModel({
    required this.userId,
    required this.date,
    required this.checkInTime,
    required this.checkOutTime,
    required this.status,
    required this.timestamp,
  });

  factory AttendanceModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return AttendanceModel(
      userId: data?['userId'] as String,
      date: data?['date'] as String,
      checkInTime: data?['checkInTime'] as String,
      checkOutTime: data?['checkOutTime'] as String?,
      status: data?['status'] as String,
      timestamp: data?['timestamp'] as Timestamp,
    );
  }

  String userId;
  String date;
  String checkInTime;
  String? checkOutTime;
  String status;
  Timestamp timestamp;

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'date': date,
      'checkInTime': checkInTime,
      'checkOutTime': checkOutTime,
      'status': status,
      'timestamp': timestamp,
    };
  }
}
