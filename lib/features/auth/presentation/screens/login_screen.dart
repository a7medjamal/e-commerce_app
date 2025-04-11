import 'package:e_commerce_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:e_commerce_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:e_commerce_app/features/auth/widgets/custom_app_bar.dart';
import 'package:e_commerce_app/features/auth/widgets/custom_text_field.dart';
import 'package:e_commerce_app/core/AppRoutes.dart';
import 'package:e_commerce_app/features/auth/widgets/custom_button.dart';
import 'package:e_commerce_app/features/auth/widgets/user_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            UserAlertDialog.show(
              context: context,
              title: 'Login Failed',
              content: state.message,
              buttonText: 'OK',
              onPressed: () => {GoRouter.of(context).pop()},
            );
          } else if (state is AuthSuccess) {
            UserAlertDialog.show(
              context: context,
              title: 'Success',
              content: 'Welcome back $_email',
              buttonText: 'OK',
              onPressed: () => {GoRouter.of(context).push(AppRouter.kHomeView)},
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomAppBar(),
                    const SizedBox(height: 150),
                    const Text(
                      'Welcome Back',
                      style: TextStyle(fontSize: 24, color: Colors.black),
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      onChanged: (data) => _email = data,
                      hintText: 'Email',
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      onChanged: (data) => _password = data,
                      hintText: 'Password',
                      obscureText: true,
                    ),
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          text: state is AuthLoading ? 'LOADING...' : 'LOGIN',
                          textColor: Colors.white,
                          backgroundColor: Colors.green,
                          onPressed: () {
                            if (_email.isEmpty || _password.isEmpty) {
                              UserAlertDialog.show(
                                context: context,
                                title: 'Error',
                                content: 'Email and password are required.',
                                buttonText: 'OK',
                                onPressed: () => GoRouter.of(context).pop(),
                              );
                              return;
                            }
                            context.read<AuthCubit>().login(_email, _password);
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
          );
        },
      ),
    );
  }
}
