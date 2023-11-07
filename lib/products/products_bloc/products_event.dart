part of 'products_bloc.dart';

@immutable
abstract class ProductsEvent {}

class GetAllProducts extends ProductsEvent {}
