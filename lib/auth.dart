import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get currentUser => _firebaseAuth.authStateChanges();

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInEmailAndPassword({
    required String email,
    String? password,
  }) async{
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: "password");
  }


Future<void> createUserWithEmailAndPassword({
  required String email,
  required String password,
}) async{
  await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
}

Future<void> signOut() async {
  await _firebaseAuth.signOut();
}
}

