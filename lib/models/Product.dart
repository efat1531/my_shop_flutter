class Product {
  final String id;
  final String title;
  final String description;
  final int price;
  final String imageUrl;
  final bool isFavourite;
  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    this.isFavourite =false,
  });
}
