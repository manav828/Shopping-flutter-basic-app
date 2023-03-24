import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProvaider {
  String? userName;
  String? phoneNumber;
  String? email;
  fetch() async {
    final firebaseUser = (await FirebaseAuth.instance.currentUser!).uid;
    print(firebaseUser);
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('UserData')
          .doc(firebaseUser)
          .get()
          .then((ds) {
        userName = ds.get('displayName');
        phoneNumber = ds.get('phone');
        email = ds.get('email');
      }).catchError((e) {
        print(e);
      });
    }
  }
}
