// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDetails{
  final email;
  final uid;
  final userName;
  final dateCreated;
  final imageURL;

  // creating the constructor here...
  UserDetails({
    required this.email,
    required this.uid,
    required this.userName,
    required this.dateCreated,
    required this.imageURL,
  });
  // converting it to the map object
  Map<String, dynamic> toJson() => {
        "createdAt": DateTime.now().toString(),
        "useremail": email,
        "userName": userName,
        "uid": FirebaseAuth.instance.currentUser!.uid,
        "imageUrl": imageURL
      };
  static UserDetails fromSnap(DocumentSnapshot documentSnapshot) {
    var snapshot = documentSnapshot.data() as Map<String, dynamic>;
    return UserDetails(
      uid: snapshot['uid'],
      email: snapshot['useremail'],
      dateCreated: snapshot['createdAt'],
      userName: snapshot['userName'],
      imageURL: snapshot['imageUrl'],
    );
  }
}
