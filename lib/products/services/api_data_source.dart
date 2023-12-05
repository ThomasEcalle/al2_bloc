import 'package:al2_bloc/models/product.dart';
import 'package:al2_bloc/products/services/products_data_source.dart';
import 'package:dio/dio.dart';

class ApiDataSource extends ProductsDataSource {
  @override
  Future<List<Product>> getAllProducts() async {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://dummyjson.com',
      ),
    );

    try {
      final response = await dio.get('/products');
      final jsonList = response.data['products'] as List;
      return jsonList.map((jsonElement) {
        return Product.fromJson(jsonElement as Map<String, dynamic>);
      }).toList();
    } catch (error) {
      rethrow;
    }
  }
}
