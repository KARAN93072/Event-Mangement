import 'dart:typed_data';

import 'package:event_management/const/spacing.dart';
import 'package:event_management/const/utils.dart';
import 'package:event_management/controller/provider/pick_image_provider.dart';
import 'package:event_management/controller/provider/sign_up_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    print('build');

    final _provider = Provider.of<SignUpProvider>(context, listen: true);
    final _pickImageProvider = Provider.of<PickImageProvider>(context);
    final _formKey = GlobalKey<FormState>();
    final _auth = FirebaseAuth.instance;
    TextEditingController _nameController = TextEditingController();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _usernameController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    ValueNotifier<bool> _obsecure = ValueNotifier<bool>(false);

    return Scaffold(
      body: Padding(
          padding: Spacing.screenSpacing.copyWith(top: 130),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Consumer<PickImageProvider>(
                        builder: (context, value, child) {
                      return Stack(children: [
                        ClipOval(
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(255, 45, 45, 45)),
                            child: value.image != null
                                ? Image.memory(
                                    value.image!,
                                    fit: BoxFit.cover,
                                  )
                                : const Icon(
                                    Icons.person,
                                    size: 40,
                                    color: Color.fromARGB(255, 135, 135, 135),
                                  ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: -3,
                          child: InkWell(
                            onTap: () async {
                              await value.getGalleryImage();
                            },
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromARGB(255, 0, 0, 0)),
                              child: const Icon(
                                Icons.add_a_photo_outlined,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ]);
                    }),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(hintText: 'name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ' Please enter the fields';
                    }
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(hintText: 'username'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ' Please enter the fields';
                    }
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(hintText: 'email'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ' Please enter the fields';
                    }
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                ValueListenableBuilder(
                  valueListenable: _obsecure,
                  builder: (context, value, child) {
                    return TextFormField(
                      controller: _passwordController,
                      obscureText: _obsecure.value,
                      decoration: InputDecoration(
                          hintText: 'password',
                          suffixIcon: InkWell(
                            onTap: () {
                              _obsecure.value = !_obsecure.value;
                            },
                            child: _obsecure.value
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                          )),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ' Please enter the fields';
                        }
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                FilledButton(
                    onPressed: () {
                      _formKey.currentState!.validate();
                      _provider.createUser(
                          _nameController.text,
                          _usernameController.text,
                          _emailController.text,
                          _passwordController.text,
                          _pickImageProvider.newUrl!,
                          context);
                      _pickImageProvider
                          .getUploadImage('/UserPhotos/ProfilePics/${_auth.currentUser!.uid}');
                    },
                    child: const Text('Sign Up')),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account? '),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          )),
    );
  }
}
