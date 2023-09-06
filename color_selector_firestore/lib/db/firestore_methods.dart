import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:color_picker/db/storage_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

import '../models/users.dart';


class FirestoreMethods {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth _auth=FirebaseAuth.instance;
  Future<String> createUser({
    required Uint8List file,
    required final uid,
    required final dateCreated,
    required final email,
    required String username,
  }) async {
    String res = "Some error occured";
    try {
      String imageURL = await StorageMethods().uploadImageToStorage(
        "users",
        file,
        true,
      );

      String userId =_auth.currentUser!.uid ;
      UserDetails user = UserDetails(
        uid: userId,
        userName: username,
        dateCreated: DateTime.now().toString(),
        email: email,
        imageURL: imageURL,
      );
      _firebaseFirestore.collection("users").doc(userId).set(user.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }


  Future<UserDetails> getUserDetails() async {
    log("refreshing user");
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snapshot = await _firebaseFirestore
        .collection("users")
        .doc(currentUser.uid)
        .get()
        .catchError(
          (onError) {
        throw Exception(onError);
      },
    );

    return UserDetails.fromSnap(snapshot);
  }

}
