import 'package:e_commerce_app/core/network/api_services.dart';
import 'package:e_commerce_app/features/home/data/models/product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ApiService apiService;

  ProductBloc({required this.apiService}) : super(ProductInitial()) {
    on<FetchProductsEvent>((event, emit) async {
      emit(ProductLoading());
      try {
        List<Product> products = await apiService.fetchProducts();
        emit(ProductLoaded(products: products));
      } catch (e) {
        emit(ProductError(message: e.toString()));
      }
    });
  }
}
