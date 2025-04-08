import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gps_attendance_system/core/models/attendance_model.dart';

class AttendanceService {
  // database instance
  static FirebaseFirestore db = FirebaseFirestore.instance;

  // create a collection called attendanceRecords
  static CollectionReference<Map<String, dynamic>> attendanceRecords =
      db.collection('attendanceRecords');

  // Get Stream of Attendance data from firestore
  static Stream<List<AttendanceModel>> getAttendanceData() {
    return attendanceRecords.snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => AttendanceModel.fromFirestore(doc))
              .toList(),
        );
  }

  // Add Attendance record to firestore
  static Future<void> addAttendanceRecord(
    AttendanceModel data,
    String docId,
  ) async {
    await attendanceRecords.doc(docId).set(data.toMap());
  }

  // Fetch company location
  static Future<DocumentSnapshot<Map<String, dynamic>>> fetchCompanyLocation() {
    return db.collection('company-location').doc('company-location').get();
  }

  // Change company geofence
  static Future<void> updateCompanyLocation(double latitude, double longitude) async {
    await db.collection('company-location').doc('company-location').update({
      'latitude': latitude,
      'longitude': longitude,
    });
  }
}
