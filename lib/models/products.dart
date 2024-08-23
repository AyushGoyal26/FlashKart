class Product{
  final int id;
  final String name;
  final String category;
  final String image;
  final String description;
  final double price;
  int quantity;
  Product({required this.id, required this.name, required this.category, required this.price, required this.description, required this.image, required this.quantity});
}