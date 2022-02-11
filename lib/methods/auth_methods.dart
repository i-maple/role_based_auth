import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> regsiterUser(String email, String password) async {
    String res = '';
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String uid = credential.user!.uid;
      await _firestore.collection('users').doc(uid).set(
        {
          'userId': uid,
          'isAdmin': false,
        },
      );
      res = 'success';
    } on FirebaseAuthException {
      FirebaseAuthException(
          code: 'email_already-in-use', message: 'Email Already In Use');
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> loginUser(String email, String password) async {
    String res = '';
    try {
       await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      res = 'success';
    } catch (e) {
      res = 'Failed';
    }
    return res;
  }

  Future<bool> checkAdmin() async {
    DocumentReference reference = _firestore.collection('users').doc(getCurrentUser);
    DocumentSnapshot snapshot = await reference.get();
    bool checkAdmin = await snapshot.get('isAdmin');
    return checkAdmin;
  }

  get getCurrentUser {
    return _auth.currentUser!.uid;
  }
}
