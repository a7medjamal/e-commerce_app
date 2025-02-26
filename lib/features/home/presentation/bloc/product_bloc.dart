import 'package:dio/dio.dart';
import 'package:e_commerce_app/features/home/data/models/product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final Dio dio;

  ProductBloc({required this.dio}) : super(ProductInitial()) {
    on<FetchProductsEvent>((event, emit) async {
      emit(ProductLoading());
      try {
        final response = await dio.get(
          'https://dummyjson.com/products?limit=30&skip=0',
        );

        List<Product> products =
            (response.data['products'] as List)
                .map((productJson) => Product.fromJson(productJson))
                .toList();

        emit(ProductLoaded(products: products));
      } catch (e) {
        emit(ProductError(message: e.toString()));
      }
    });
  }
}
