import 'package:al2_bloc/models/product.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<AddProduct>(_onAddProduct);
  }

  void _onAddProduct(AddProduct event, Emitter<CartState> emit) async {
    emit(state.copyWith(status: CartStatus.addingProduct));

    try {
      await Future.delayed(const Duration(seconds: 1));
      if (event.product.name == 'iPhone X') {
        throw Exception();
      }

      emit(
        state.copyWith(
          status: CartStatus.successAddingProduct,
          products: [
            ...state.products,
            event.product,
          ],
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: CartStatus.errorAddingProduct,
          exception: Exception(),
        ),
      );
    }
  }
}
