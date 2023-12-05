import 'package:al2_bloc/models/product.dart';
import 'package:al2_bloc/products/cart_bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailScreen extends StatelessWidget {
  static const String routeName = '/productDetail';

  static void navigateTo(BuildContext context, Product product) {
    Navigator.of(context).pushNamed(routeName, arguments: product);
  }

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
      listener: (context, state) {
        if (state.status == CartStatus.errorAddingProduct) {
          _showSnackBar(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('${product.name}'),
        ),
        body: Column(
          children: [
            Text('${product.price} euros'),
          ],
        ),
        floatingActionButton: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            final loading = state.status == CartStatus.addingProduct;
            return FloatingActionButton(
              child: Icon(loading ? Icons.refresh : Icons.add),
              onPressed: () => _onAddProduct(context),
            );
          },
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('coucou'),
      ),
    );
  }

  void _onAddProduct(BuildContext context) {
    //final cartBloc = BlocProvider.of<CartBloc>(context);
    final cartBloc = context.read<CartBloc>();
    cartBloc.add(AddProduct(product: product));
  }
}
