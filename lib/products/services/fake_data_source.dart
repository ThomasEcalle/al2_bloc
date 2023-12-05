import 'package:al2_bloc/models/product.dart';
import 'package:al2_bloc/products/services/products_data_source.dart';

class FakeDataSource extends ProductsDataSource {
  @override
  Future<List<Product>> getAllProducts() async {
    await Future.delayed(const Duration(seconds: 3));
    return List.generate(3, (index) {
      return Product(
        name: 'Product $index',
        price: index,
      );
    });
  }
}
