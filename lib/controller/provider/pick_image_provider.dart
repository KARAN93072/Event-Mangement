import 'dart:typed_data';

import 'package:event_management/const/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImageProvider extends ChangeNotifier {
  final _firebaseStorageRef = FirebaseStorage.instance.ref('UserProfilePics');
  final _auth = FirebaseAuth.instance;
  final _firebaseDatabaseRef = FirebaseDatabase.instance;
  Uint8List? _image;
  Uint8List? get image => _image;
  String? _newUrl = '';
  String? get newUrl => _newUrl;
  final picker = ImagePicker();
  getGalleryImage() async {
    XFile? pickerPath = await picker.pickImage(source: ImageSource.gallery);
    if (pickerPath != null) {
      _image = await pickerPath.readAsBytes();
      Utils().toastMessage('Image selected');
      notifyListeners();
    } else {
      Utils().toastMessage('No Image selected');
    }
  }

  getUploadImage(String? imagePath) async {
    try {
      if (_image != null) {
        _firebaseStorageRef.child(imagePath!);
        UploadTask uploadTask = _firebaseStorageRef.putData(_image!);
        TaskSnapshot taskSnapshot = await uploadTask;
        var newUrl = await taskSnapshot.ref.getDownloadURL().then((onValue) {
          Utils().toastMessage('Image uploaded');
        }).onError((error, stackTrace) {
          Utils().toastMessage('$error');
        });
      } else {
        Utils().toastMessage('Error occured');
      }
    } catch (e) {
      Utils().toastMessage(e.toString());
    }
  }
}
