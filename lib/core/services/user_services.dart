import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gps_attendance_system/core/models/user_model.dart';

class UserService {
  //--------- Firebase auth feature --------//
  static FirebaseAuth authInstance = FirebaseAuth.instance;

  //--- Sign in with email and password method ---//
  static Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final credentials = await authInstance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credentials.user;
  }

  //--- Create user with email and password ---//
  static Future<User?> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final credential = await authInstance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user;
  }

  // Log out from firebase auth
  static Future<void> signOut() async => authInstance.signOut();

  //-------- Firebase firestore feature --------//

  // database instance
  static FirebaseFirestore db = FirebaseFirestore.instance;

  // create a collection called users
  static CollectionReference<Map<String, dynamic>> users =
      db.collection('users');

  // Add user document to the collection users in database
  // After adding an user, from the admin side.
  static Future<void> addUser(String uid, UserModel user) async {
    await users.doc(uid).set(user.toJson());
  }

  // Get user data from firestore
  static Future<UserModel?> getUserData(String uid) async {
    try {
      final DocumentSnapshot<Object?> docSnapshot = await users.doc(uid).get();

      if (docSnapshot.exists && docSnapshot.data() != null) {
        return UserModel.fromFirestore(
          docSnapshot as DocumentSnapshot<Map<String, dynamic>>,
        );
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Error getting user data: $e');
    }
  }

  // Update user data
  static Future<void> updateUserData({
    required UserModel user,
    required String userId,
  }) async {
    await users.doc(userId).update(user.toJson());
  }

  //-- Get all users data from firestore --//
  static Future<List<UserModel>> getAllUsers() async {
    final snapshot = await users.get();
    List<UserModel> usersData = [];
    for (final doc in snapshot.docs) {
      usersData.add(
        UserModel.fromFirestore(
          doc as DocumentSnapshot<Map<String, dynamic>>,
        ),
      );
    }
    return usersData;
  }

  // Get current user id
  static String? getCurrentUserId() {
    return FirebaseAuth.instance.currentUser?.uid;
  }

  // method to retrieve the contact number of current user

  // Fetch the current user's contact number
  static Future<String?> getCurrentUserContactNumber() async {
    final userId = getCurrentUserId();
    if (userId != null) {
      final userDoc = await users.doc(userId).get();
      if (userDoc.exists) {
        final userData = userDoc.data();
        final contactNumber = userData?['contactNumber'] as String?;
        return contactNumber;
      }
    }
    return null;
  }

  // Update gender for all users
  static Future<void> updateAllUsersGender() async {
    final snapshot = await users.get();
    for (final doc in snapshot.docs) {
      final data = doc.data() as Map<String, dynamic>;
      if (!data.containsKey('gender')) {
        await users.doc(doc.id).update({'gender': 'male'});
      }
    }
  }
}
