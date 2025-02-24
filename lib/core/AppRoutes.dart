import 'package:e_commerce_app/auth/login_screen.dart';
import 'package:e_commerce_app/auth/register_screen.dart';
import 'package:e_commerce_app/screens/home_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static const String kHomeView = '/home';
  static const String kLoginView = '/login';
  static const String kRegisterView = '/register';

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const LoginScreen()),
      GoRoute(path: kHomeView, builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: kRegisterView,
        builder: (context, state) => const RegisterScreen(),
      ),
    ],
  );
}
