import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/AppRoutes.dart';
import 'package:e_commerce_app/core/network/api_services.dart';
import 'package:e_commerce_app/features/home/presentation/bloc/product_bloc.dart';
import 'package:e_commerce_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const EcommerceApp());
}

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductBloc>(
      create:
          (context) =>
              ProductBloc(apiService: ApiService(Dio()))
                ..add(FetchProductsEvent()),
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            scrolledUnderElevation: 0,
          ),
        ),
      ),
    );
  }
}
