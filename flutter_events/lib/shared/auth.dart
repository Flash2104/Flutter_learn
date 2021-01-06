import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> login(String email, String password) async {
    UserCredential res = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return res.user.uid;
  }

  Future<String> signUp(String email, String password) async {
    UserCredential res = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return res.user.uid;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<User> getUser() async {
    var user = _firebaseAuth.currentUser;
    return user;
  }
}
