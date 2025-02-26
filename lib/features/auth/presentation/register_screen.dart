// ignore_for_file: unused_local_variable, use_build_context_synchronously
import 'package:e_commerce_app/features/auth/data/user_register.dart';
import 'package:e_commerce_app/features/auth/widgets/custom_app_bar.dart';
import 'package:e_commerce_app/features/auth/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

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
                const CustomAppBar(),
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
