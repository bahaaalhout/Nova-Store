import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static const String userCollection = 'users';

  saveUserData(Map<String, dynamic> userData, String userId) async {
    await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(userId)
        .set(userData);
  }
}
