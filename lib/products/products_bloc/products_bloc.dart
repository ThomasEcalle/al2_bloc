import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/product.dart';
import '../services/products_repository.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsRepository productsRepository;

  ProductsBloc({required this.productsRepository}) : super(ProductsState()) {
    on<GetAllProducts>(_onGetAllProducts);
  }

  void _onGetAllProducts(GetAllProducts event, Emitter<ProductsState> emit) async {
    emit(state.copyWith(status: ProductsStatus.loading));

    try {
      final products = await productsRepository.getAllProducts();

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
}
