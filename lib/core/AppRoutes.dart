
import 'package:e_commerce_app/auth/login_screen.dart';
import 'package:e_commerce_app/auth/register_screen.dart';
import 'package:e_commerce_app/screens/home_screen.dart';
import 'package:go_router/go_router.dart';

GoRouter AppRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
  ],
);
