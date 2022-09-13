import 'package:cloud_firestore/cloud_firestore.dart';

class UserProvider {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  Stream<QuerySnapshot<Map<String, dynamic>>> allUser() {
    return _fireStore.collection("users").snapshots();
  }

  int len = 0;
  Future conut() async {
    len = await _fireStore.collection("users").snapshots().length;
  }

  int get totalUser {
    return len;
  }
}
