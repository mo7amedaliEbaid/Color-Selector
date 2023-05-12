import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthServiceProvider extends ChangeNotifier {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Future<User?> getUserState() async {
    if (currentUser == null) {
      await _firebaseAuth.signInAnonymously();
    }
    notifyListeners();
    return currentUser;
  }
}
