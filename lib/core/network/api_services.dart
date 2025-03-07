import 'package:dio/dio.dart';
import 'package:e_commerce_app/features/home/data/models/product_model.dart';

class ApiService {
  final Dio dio;

  ApiService(this.dio);

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await dio.get(
        'https://dummyjson.com/products?limit=30&skip=0',
      );
      List<Product> products =
          (response.data['products'] as List)
              .map((productJson) => Product.fromJson(productJson))
              .toList();
      return products;
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }
}
