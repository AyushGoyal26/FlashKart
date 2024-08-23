class CartModel {
  String img;
  int id;
  String productName;
  double productAmount;
  int productQty;
  double total;

  CartModel({
    required this.img,
    required this.id,
    required this.productName,
    required this.productAmount,
    this.productQty = 1,
    required this.total
  });
}