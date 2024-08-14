import 'dart:math';
import 'package:event_management/const/spacing.dart';
import 'package:event_management/controller/provider/sign_in_provider.dart';
import 'package:event_management/views/auth/sign_up/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    ValueNotifier<bool> _obsecure = ValueNotifier<bool>(false);
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      body: Container(
          height: double.infinity,
          padding: Spacing.screenSpacing.copyWith(top: 130),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
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
                        obscureText: _obsecure.value,
                        controller: _passwordController,
                        decoration: InputDecoration(
                            hintText: 'password',
                            suffixIcon: InkWell(
                              onTap: () {
                                print(_obsecure.value);
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
                    }),
                const SizedBox(
                  height: 25,
                ),
                Consumer<SignInProvider>(builder: (context, value, child) {
                  return FilledButton(
                      onPressed: () {
                        _formKey.currentState!.validate();
                        value.loginUser(_emailController.text,
                            _passwordController.text, context);
                      },
                      child: value.isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : const Text('Submit'));
                }),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don\'t have an account? '),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => const SignUp()));
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          )),
    );
  }
}
