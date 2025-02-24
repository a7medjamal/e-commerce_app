// ignore_for_file: use_build_context_synchronously

import 'package:e_commerce_app/auth/widgets/custom_text_field.dart';
import 'package:e_commerce_app/core/AppRoutes.dart';
import 'package:e_commerce_app/core/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomAppBarr(),
                const SizedBox(height: 150),
                const Text(
                  'Welcome Back',
                  style: TextStyle(fontSize: 24, color: Colors.black),
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  onChanged: (data) {
                    _email = data;
                  },
                  hintText: 'Email',
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  onChanged: (data) {
                    _password = data;
                  },
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: 'LOGIN',
                      textColor: Colors.white,
                      backgroundColor: Colors.green,
                      onPressed: () {
                        if (_email.isEmpty || _password.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Error'),
                                content: const Text('Email and password are required.'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(),
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                          return;
                        }
                        signInWithEmailAndPassword(_email, _password, context);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: 'REGISTER NOW',
                      textColor: Colors.white,
                      backgroundColor: Colors.green,
                      onPressed: () {
                        GoRouter.of(context).push(AppRouter.kRegisterView);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomAppBarr extends StatelessWidget {
  const CustomAppBarr({super.key});
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 40, bottom: 15),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Flutter Shopify',
              style: TextStyle(color: Colors.black, fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> signInWithEmailAndPassword(
  String email,
  String password,
  BuildContext context,
) async {
  try {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    Navigator.of(context).pop();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: const Text('Signed in successfully!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Future.delayed(const Duration(milliseconds: 300), () {
                  GoRouter.of(context).go(AppRouter.kHomeView);
                });
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  } catch (e) {
    Navigator.of(context).pop();
    String errorMessage = 'Failed to sign in. Please try again.';
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found with this email.';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect password. Please try again.';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email format.';
          break;
        default:
          errorMessage = e.message ?? errorMessage;
      }
    }

    if (kDebugMode) {
      print('Failed to sign in: $e');
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
