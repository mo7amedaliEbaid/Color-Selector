import 'dart:developer';

import 'package:color_picker/db/firestore_methods.dart';
import 'package:color_picker/models/users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';


class UserProvider extends ChangeNotifier{
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

  Future<bool> userLogin( String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
  UserDetails _users=UserDetails(email: "mo7amedaliebaid@gmail.com", uid: "", userName: "Mohamed Ali", dateCreated: DateTime.now().toString(), imageURL: null);
  bool isLoading = false;
  final FirestoreMethods _firestoreMethods = FirestoreMethods();
  // getter of the _users
  UserDetails get getUser => _users;
  Future<void> refreshUser() async {
    print("\n\n\nWorking tree file");
    isLoading = true;
    UserDetails userCreaditials = await _firestoreMethods.getUserDetails();
    _users = userCreaditials;
    print("\n\n\nWorking tree file");
    isLoading = false;
    notifyListeners();
  }
}
