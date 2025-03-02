// ignore_for_file: file_names

import 'package:e_commerce_app/features/auth/presentation/login_screen.dart';
import 'package:e_commerce_app/features/auth/presentation/register_screen.dart';
import 'package:e_commerce_app/features/home/data/models/product_model.dart';
import 'package:e_commerce_app/features/home/presentation/home_screen.dart';
import 'package:e_commerce_app/features/home/presentation/products_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static const String kHomeView = '/home';
  static const String kLoginView = '/';
  static const String kRegisterView = '/register';
  static const String kProductView = '/product';

  static final GoRouter router = GoRouter(
    initialLocation: kLoginView,
    routes: [
      GoRoute(path: kHomeView, builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: kLoginView,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: kRegisterView,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: kProductView,
        builder: (context, state) {
          final product = state.extra as Product;
          return ProductDetailScreen(product: product);
        },
      ),
    ],
  );
}
