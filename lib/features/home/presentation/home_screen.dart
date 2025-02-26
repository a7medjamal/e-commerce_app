import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_app/features/home/presentation/bloc/product_bloc.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/photo_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(dio: Dio())..add(FetchProductsEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(height: 10),
                Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff787676),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Wearify',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff121111),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 15, right: 15),
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffe8e8e8),
                ),
                child: IconButton(
                  icon: SvgPicture.asset('assets/icons/profile_icon.svg'),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ProductError) {
                return Center(child: Text('Error: ${state.message}'));
              } else if (state is ProductLoaded) {
                return GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.65,
                  ),
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    return PhotoCard(product: state.products[index]);
                  },
                );
              } else {
                return const Center(child: Text('No products available'));
              }
            },
          ),
        ),
      ),
    );
  }
}
