import 'package:bloc/bloc.dart';
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
        error: error as Exception,
      ));
    }
  }

  Future<List<Product>> getAllProducts() async {
    await Future.delayed(const Duration(seconds: 2));
    //throw Exception('Coucou');
    return const [
      Product(name: 'iPhone 15', price: 10),
      Product(name: 'Pixel 7', price: 42),
    ];
  }
}
