import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

Future<bool> userSignup(String username, String email, String password) async {
  try {
    await _auth.createUserWithEmailAndPassword(email: email, password: password);
    return true;
  } catch (e) {
    log(e.toString());
    return false;
  }
}


