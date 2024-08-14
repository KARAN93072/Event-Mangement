import 'package:event_management/views/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInProvider extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  startLoading() {
    _isLoading = true;
    notifyListeners();
  }

  stopLoading() {
    _isLoading = false;
    notifyListeners();
  }

  Future loginUser(String email, String password, BuildContext context) async {
    ///validator
    startLoading();
    try {
      ///Authentication
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        ///Navigate to Home page
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => HomeScreen()));
        stopLoading();
        print('Login successfully');
        stopLoading();
      }
      stopLoading();
    } catch (e) {
      stopLoading();
      print(e.toString());
    }
  }
}
