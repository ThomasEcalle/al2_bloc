import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../models/product.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(ProductsState()) {
    on<GetAllProducts>(_onGetAllProducts);
  }

  void _onGetAllProducts(GetAllProducts event, Emitter<ProductsState> emit) async {
    emit(state.copyWith(status: ProductsStatus.loading));

    try {
      final products = await getAllProducts();

      emit(state.copyWith(
        status: ProductsStatus.success,
        products: products,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: ProductsStatus.error,
        error: Exception(),
      ));
    }
  }

  Future<List<Product>> getAllProducts() async {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://dummyjson.com',
      ),
    );

    try {
      final response = await dio.get('/products');
      final jsonList = response.data['products'] as List;
      return jsonList.map((jsonElement) {
        return Product.fromJson(jsonElement as Map<String, dynamic>);
      }).toList();
    } catch (error) {
      rethrow;
    }
  }
}
