import 'package:al2_bloc/products/cart_bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({
    super.key,
    required this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        final productsNumber = state.products.length;
        return GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              Text('($productsNumber)'),
              const Icon(Icons.shopping_cart),
            ],
          ),
        );
      },
    );
  }
}
