
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {

final _auth = FirebaseAuth.instance;
    void logout() {
    _auth.signOut();
    notifyListeners();
  }
}
  







////////////////Old Code
//   FirebaseStorage _storage = FirebaseStorage.instance;
//   Uint8List? _image;
//   Uint8List? get image => _image;
//   final picker = ImagePicker();

//   uploadImage() async {
//     XFile? file = await picker.pickImage(source: ImageSource.gallery);
//     if (file != null) {

//       _image = await file.readAsBytes();
//       try {
//         if (_image != null) {
//           ///Show file size
//           // Uint8List fileSize = await _image!.length();
//           // Utils().toastMessage('File size: $fileSize bytes');

//           ///Upload Image to FireStore
//           final storageRef =
//               FirebaseStorage.instance.ref('/ProfilePics/' + '1');
//           // Reference ref = _storage.ref().child('ProfilePic').child('imageName');
//           UploadTask uploadTask = storageRef.putData(_image!);
//           TaskSnapshot taskSnapshot = await uploadTask;
//           var newUrl = await taskSnapshot.ref.getDownloadURL();

//           print('Profile uploaded successfully $newUrl');
//         } else {
//           return null;
//         }
//       } catch (e) {
//         print(e.toString());
//       }
//     } else {
//       print('no file selected');
//     }
//     notifyListeners();
//   }




///////////Apurv's code
// pickImage() async {
//     XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
//     if (file != null) {
//       image = await file.readAsBytes();
//       notifyListeners();
//     } else {
//       print("No image selected");
//     }
//   }