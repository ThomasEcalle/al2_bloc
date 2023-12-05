import 'package:al2_bloc/models/product.dart';

abstract class ProductsDataSource {
  Future<List<Product>> getAllProducts();
}
