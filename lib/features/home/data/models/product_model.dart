class Product {
  final String title;
  final double price;
  final String image;

  Product({required this.title, required this.price, required this.image});
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      title: json['title'] ?? 'Unknown Title',
      price: (json['price'] ?? 0.0).toDouble(),
      image: json['thumbnail'] ?? '',
    );
  }
}
