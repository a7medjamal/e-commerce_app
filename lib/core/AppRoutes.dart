// ignore_for_file: file_names

import 'package:e_commerce_app/auth/login_screen.dart';
import 'package:e_commerce_app/auth/register_screen.dart';
import 'package:e_commerce_app/features/home/home_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static const String kHomeView = '/home';
  static const String kLoginView = '/';
  static const String kRegisterView = '/register';

  static final GoRouter router = GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(path: kHomeView, builder: (context, state) => const HomeScreen()),
      GoRoute(path: '/', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: kRegisterView,
        builder: (context, state) => const RegisterScreen(),
      ),
    ],
  );
}
