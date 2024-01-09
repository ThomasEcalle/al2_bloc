import 'package:al2_bloc/models/product.dart';
import 'package:al2_bloc/products/cart_screen/cart_screen.dart';
import 'package:al2_bloc/products/product_detail_screen/product_detail_screen.dart';
import 'package:al2_bloc/products/products_bloc/products_bloc.dart';
import 'package:al2_bloc/products/widgets/cart_icon.dart';
import 'package:al2_bloc/products/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    super.initState();
    final productsBloc = BlocProvider.of<ProductsBloc>(context);
    productsBloc.add(GetAllProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          CartIcon(
            onTap: () => _onCartIconTap(context),
          )
        ],
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          switch (state.status) {
            case ProductsStatus.initial || ProductsStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ProductsStatus.error:
              return const Center(
                child: Text('Oups, une erreur est survenue.'),
              );
            case ProductsStatus.success:
              final products = state.products;
              return ListView.separated(
                itemCount: products.length,
                separatorBuilder: (context, _) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductItem(
                    product: product,
                    onTap: () => _onProductTap(context, product),
                  );
                },
              );
          }
        },
      ),
    );
  }

  void _onProductTap(BuildContext context, Product product) {
    ProductDetailScreen.navigateTo(context, product);
  }

  void _onCartIconTap(BuildContext context) {
    CartScreen.navigateTo(context);
  }
}
