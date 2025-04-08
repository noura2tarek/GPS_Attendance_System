import 'package:cloud_firestore/cloud_firestore.dart';

class LeaveModel {
  LeaveModel({
    required this.title,
    required this.leaveType,
    required this.contactNumber,
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.userId,
    required this.id,
    this.status = 'Pending',
  });

  factory LeaveModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return LeaveModel(
      title: data?['title'] as String,
      id: data?['id'] as String,
      leaveType: data?['leaveType'] as String,
      contactNumber: data?['contactNumber'] as String,
      startDate: data?['startDate'] as Timestamp,
      endDate: data?['endDate'] as Timestamp,
      reason: data?['reason'] as String,
      userId: data?['userId'] as String,
      status: data?['status'] as String,
    );
  }

  String title;
  String leaveType;
  String contactNumber;
  Timestamp startDate;
  Timestamp endDate;
  String reason;
  String userId;
  String id;
  String status; // Pending, Approved, Rejected

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'leaveType': leaveType,
      'contactNumber': contactNumber,
      'startDate': startDate,
      'endDate': endDate,
      'reason': reason,
      'userId': userId,
      'status': status,
      'id': id,
    };
  }
}
