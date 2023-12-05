import 'package:al2_bloc/products/services/products_data_source.dart';

import '../../models/product.dart';

class ProductsRepository {
  final ProductsDataSource productsDataSource;

  ProductsRepository({required this.productsDataSource});

  Future<List<Product>> getAllProducts() async {
    return productsDataSource.getAllProducts();
  }
}
