class Product {
  final int id;
  final String title;
  final String category;
  final String image;
  final double price;
  final String description; // Add description field

  Product({
    required this.id,
    required this.title,
    required this.category,
    required this.image,
    required this.price,
    required this.description, // Add description to constructor
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      image: json['image'],
      price: (json['price'] as num).toDouble(),
      description: json['description'], // Parse description from JSON
    );
  }
}
