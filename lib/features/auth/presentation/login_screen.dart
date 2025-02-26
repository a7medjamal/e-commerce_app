// ignore_for_file: use_build_context_synchronously

import 'package:e_commerce_app/features/auth/widgets/custom_text_field.dart';
import 'package:e_commerce_app/core/AppRoutes.dart';
import 'package:e_commerce_app/features/auth/widgets/custom_button.dart';
import 'package:e_commerce_app/features/auth/widgets/user_alert.dart';
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
                          UserAlertDialog(
                            context: context,
                            title: 'Error',
                            content: 'Email and password are required.',
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            buttonText: 'OK',
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
    GoRouter.of(context).pop();
    UserAlertDialog(
      context: context,
      title: 'Success',
      content: 'Welcome back ${userCredential.user!.email}',
      onPressed: () {
        GoRouter.of(context).push(AppRouter.kHomeView);
      },
      buttonText: 'OK',
    );
  } catch (e) {
    GoRouter.of(context).pop();
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
    UserAlertDialog(
      context: context,
      title: 'Error',
      content: errorMessage,
      onPressed: () {
        GoRouter.of(context).push(AppRouter.kLoginView);
      },
      buttonText: 'OK',
    );
  }
}
