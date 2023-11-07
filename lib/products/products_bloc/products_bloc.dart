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
    print('Coucou, on fait l\'appel réseau');
    await Future.delayed(Duration(seconds: 2));
    final newState = ProductsState(
      products: [
        Product(name: 'iPhone 15', price: 10),
        Product(name: 'Pixel 7', price: 42),
      ],
    );

    emit(newState);
  }
}
