import 'package:flutter/material.dart';
import 'package:techstore/models/product.dart';
import 'package:techstore/widgets/cart_item_widget.dart';
import 'package:techstore/models/cartitem.dart';

class CartPage extends StatefulWidget {
  final List<Product> cartItems;
  final Function(List<Product>) onUpdateCart;

  const CartPage({
    super.key,
    required this.cartItems,
    required this.onUpdateCart,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late List<Product> _cartItems;

  @override
  void initState() {
    super.initState();
    _cartItems = List.from(widget.cartItems);
  }

  double _calculateTotal() {
    return _cartItems.fold(0, (total, item) => total + item.price);
  }

  void _increaseQuantity(int index) {
    // Dans une version plus avancée, on gérerait les quantités
    // Pour l'instant, on duplique l'item
    setState(() {
      _cartItems.add(_cartItems[index]);
    });
    widget.onUpdateCart(_cartItems);
  }

  void _decreaseQuantity(int index) {
    setState(() {
      _cartItems.removeAt(index);
    });
    widget.onUpdateCart(_cartItems);
  }

  void _removeItem(int index) {
    setState(() {
      _cartItems.removeAt(index);
    });

    widget.onUpdateCart(_cartItems);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Produit retiré du panier'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Panier', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: _cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 100,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Votre panier est vide',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _cartItems.length,
                    itemBuilder: (context, index) {
                      final product = _cartItems[index];
                      return CartWidget(
                        item: CartItem(
                          id: '${index}',
                          productId: product.id,
                          title: product.title,
                          price: product.price,
                          quantity: 1, // Version simplifiée
                        ),
                        onIncrease: () => _increaseQuantity(index),
                        onDecrease: () => _decreaseQuantity(index),
                        onRemove: () => _removeItem(index),
                      );
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 3, 106, 15),
                    border: Border(
                      top: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'TOTAL GÉNÉRAL:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '${_calculateTotal().toStringAsFixed(2)} €',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
