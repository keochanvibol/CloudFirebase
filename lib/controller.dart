import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future<String?> login(String email, String password) async {
    String message = 'message';
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      message = 'success';

      //  print('signIn');
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          message = e.code;
          break;
        case 'invalid-password':
          message = e.code;
          break;
        case 'wrong-password':
          message = e.code;
          break;
        case 'user-not-found':
          message = e.code;
          break;
      }
      print(e);
    }
    return message;
  }
}
