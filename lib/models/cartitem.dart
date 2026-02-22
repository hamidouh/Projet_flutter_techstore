// creation du model CartItem
class CartItem {
  final String id;
  final String productId;
  final String title;
  final double price;
  int quantity;

  CartItem({
    required this.id,
    required this.productId,
    required this.title,
    required this.price,
    this.quantity = 1,
  });
  double get subtotal => price * quantity;
}
