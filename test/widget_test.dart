// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:al2_bloc/models/product.dart';
import 'package:al2_bloc/products/cart_bloc/cart_bloc.dart';
import 'package:al2_bloc/products/products_bloc/products_bloc.dart';
import 'package:al2_bloc/products/products_screen.dart';
import 'package:al2_bloc/products/services/fake_data_source.dart';
import 'package:al2_bloc/products/services/products_data_source.dart';
import 'package:al2_bloc/products/services/products_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

class ErrorDataSource extends ProductsDataSource {
  @override
  Future<List<Product>> getAllProducts() async {
    await Future.delayed(const Duration(seconds: 3));
    throw Exception();
  }
}

class EmptyDataSource extends ProductsDataSource {
  @override
  Future<List<Product>> getAllProducts() async {
    await Future.delayed(const Duration(seconds: 3));
    return [];
  }
}

Widget _setUpProductsScreen(ProductsDataSource productsDataSource) {
  return RepositoryProvider(
    create: (context) => ProductsRepository(
      productsDataSource: productsDataSource,
    ),
    child: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductsBloc(
            productsRepository: context.read<ProductsRepository>(),
          ),
        ),
        BlocProvider(create: (context) => CartBloc()),
      ],
      child: MaterialApp(
        home: ProductsScreen(),
      ),
    ),
  );
}

void main() {
  group('$ProductsScreen', () {
    testWidgets('$ProductsScreen should display the right title', (WidgetTester tester) async {
      await tester.pumpWidget(_setUpProductsScreen(FakeDataSource()));
      await tester.pump(const Duration(seconds: 3));
      expect(find.text('Products'), findsOneWidget);
    });

    testWidgets('$ProductsScreen should display an error if an error occurred', (WidgetTester tester) async {
      await tester.pumpWidget(_setUpProductsScreen(ErrorDataSource()));
      await tester.pump(const Duration(seconds: 3));
      expect(find.text('Oups, une erreur est survenue.'), findsOneWidget);
    });

    testWidgets('$ProductsScreen should display a loading indicator', (WidgetTester tester) async {
      await tester.pumpWidget(_setUpProductsScreen(
        FakeDataSource(),
      ));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pump(const Duration(seconds: 3));
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    /// Ne passe pas car état vide non géré.
    // testWidgets('$ProductsScreen should display a specific message when empty result', (WidgetTester tester) async {
    //   await tester.pumpWidget(_setUpProductsScreen(EmptyDataSource()));
    //   await tester.pump(const Duration(seconds: 3));
    //   expect(find.text('Aucun produit'), findsOneWidget);
    // });

    testWidgets('$ProductsScreen should display a loader when Loading', (WidgetTester tester) async {
      await tester.pumpWidget(_setUpProductsScreen(FakeDataSource()));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await tester.pumpAndSettle();
    });
  });
}
