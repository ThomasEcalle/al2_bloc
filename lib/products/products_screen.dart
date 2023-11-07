import 'package:al2_bloc/products/products_bloc/products_bloc.dart';
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
        title: Text('Products'),
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          switch (state.status) {
            case ProductsStatus.initial:
              return const SizedBox();
            case ProductsStatus.loading:
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
                  return ListTile(
                    title: Text(product.name ?? ''),
                    subtitle: Text('${product.price}'),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
