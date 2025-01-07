import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //instance of FirebaseAuth
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//method to sign in with email and password
  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
  //method to sign up with email and password
  Future<UserCredential> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }
//sign out
  Future<void> signOut() async {
   return await firebaseAuth.signOut();
  }

}