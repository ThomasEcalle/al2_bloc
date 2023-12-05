import 'package:al2_bloc/models/product.dart';
import 'package:al2_bloc/products/cart_bloc/cart_bloc.dart';
import 'package:al2_bloc/products/cart_screen/cart_screen.dart';
import 'package:al2_bloc/products/products_bloc/products_bloc.dart';
import 'package:al2_bloc/products/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'products/product_detail_screen/product_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProductsBloc()),
        BlocProvider(create: (context) => CartBloc()),
      ],
      child: MaterialApp(
        routes: {
          '/': (context) => const ProductsScreen(),
          CartScreen.routeName: (context) => const CartScreen(),
        },
        onGenerateRoute: (settings) {
          Widget content = const SizedBox();

          switch (settings.name) {
            case ProductDetailScreen.routeName:
              final arguments = settings.arguments;
              if (arguments is Product) {
                content = ProductDetailScreen(product: arguments);
              }
              break;
          }

          return MaterialPageRoute(builder: (context) => content);
        },
      ),
    );
  }
}
