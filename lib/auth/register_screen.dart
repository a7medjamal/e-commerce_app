// ignore_for_file: unused_local_variable, use_build_context_synchronously
import 'package:e_commerce_app/auth/widgets/custom_text_field.dart';
import 'package:e_commerce_app/core/AppRoutes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/custom_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late String _email;
  late String _password, password2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomAppBarr(showUserName: false),
                const SizedBox(height: 150),
                const Text(
                  'Register!',
                  style: TextStyle(fontSize: 24, color: Colors.black),
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  onChanged: (data) {
                    _email = data;
                  },
                  hintText: 'Email',
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  onChanged: (data) {
                    _password = data;
                  },
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  onChanged: (data) {
                    password2 = data;
                  },
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    text: 'REGISTER',
                    textColor: Colors.white,
                    backgroundColor: Colors.green,
                    onPressed: () {
                      registerWithEmailAndPassword(
                        _email,
                        _password,
                        password2,
                        context,
                      );
                    },
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
  const CustomAppBarr({
    super.key,
    this.userName = 'User',
    required this.showUserName,
  });
  final String userName;
  final bool showUserName;
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

Future<void> registerWithEmailAndPassword(
  String email,
  String password,
  String confirmPassword,
  BuildContext context,
) async {
  try {
    if (password != confirmPassword) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: const Text('Error'),
            content: const Text('Passwords do not match.'),
            actions: <Widget>[
              TextButton(onPressed: () {}, child: const Text('OK')),
            ],
          );
        },
      );
      return;
    }

    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Success'),
          content: const Text('Registered successfully! \nLogin now!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                GoRouter.of(context).go(AppRouter.kLoginView);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  } catch (e) {
    String errorMessage = 'Something went wrong. Please try again.';
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'This email is already registered.';
          break;
        case 'weak-password':
          errorMessage = 'Password should be at least 6 characters.';
          break;
        case 'invalid-email':
          errorMessage = 'Please enter a valid email address.';
          break;
        default:
          errorMessage = e.message ?? errorMessage;
      }
    }

    if (kDebugMode) {
      print('Failed to register: $e');
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Error'),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(onPressed: () {}, child: const Text('OK')),
          ],
        );
      },
    );
  }
}
