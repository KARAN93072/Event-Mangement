import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_management/const/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class SignUpProvider extends ChangeNotifier {
  ///Authentication instance
  final _auth = FirebaseAuth.instance;

  ///FirestoreDatabase instance
  final _firebaseFirestore = FirebaseFirestore.instance;
  final _firebaseDatabaseRef = FirebaseDatabase.instance.ref('users');


  /// Create User
  Future createUser(String name, String username, String email, String password,String imageUrl,
      context) async {
    try {
      if (name.isNotEmpty ||
          username.isNotEmpty ||
          email.isNotEmpty ||
          password.isNotEmpty) {
        /// Create User | Authentication
        await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print('Authentication successfull');

        ///Adding User Details in Database
        _firebaseDatabaseRef.child(_auth.currentUser!.uid).set({
          'uid': _auth.currentUser!.uid,
          'name': name,
          'username': username,
          'email': email,
          'password': password,
          'photo_url': '$imageUrl',
          'isOrganizer': true,
          'event_id': [],
          'event_bookmarks': []
        }).then(
          (value) {
            Utils()
                .toastMessage('Congratulations...!,\n Registration completed');
                
          },
        ).onError(
          (error, stackTrace) {
            Utils()
                .toastMessage('Sorry, got some error \n ${error.toString()}');
            print(error.toString());
          },
        );
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'email-already-in-use')
        Utils().toastMessage(
            'The email address is already in use by another account.' +
                err.toString());
      print(err.toString());
    } catch (err) {
      Utils().toastMessage(err.toString());
      print(err.toString());
    }
  }
}
