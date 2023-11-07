class Product {
  final String? name;
  final int? price;

  const Product({
    this.name,
    this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['title'],
      price: json['price'],
    );
  }
}
