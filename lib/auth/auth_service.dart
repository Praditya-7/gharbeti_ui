import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static Future<User?> loginWithEmail(
      String email, String password, BuildContext context) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return user.user;
    } catch (e) {
      print(e);
    }
  }

  static Future<User?> createAccount(String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await result.user!.sendEmailVerification();
      return result.user;
    } catch (e) {
      print(e);
    }
  }
}
