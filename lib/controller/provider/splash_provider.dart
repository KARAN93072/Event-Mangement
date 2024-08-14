import 'dart:async';

import 'package:event_management/views/auth/sign_in/sign_in.dart';
import 'package:event_management/views/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  splash(BuildContext context) {
    final user = _auth.currentUser;

    if (user != null) {
      Timer(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => HomeScreen()));
      });
    } else {
      Timer(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => SignIn()));
      });
    }
  }
}
