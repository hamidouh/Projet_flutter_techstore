import 'package:flutter/material.dart';
import 'package:techstore/models/product.dart';
// import 'package:techstore/models/cartitem.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final Function ajAuPanier;

  const ProductItem({
    super.key,
    required this.product,
    required this.ajAuPanier,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Image.network(product.imageUrl, fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  '${product.price} €',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 2, 120, 47),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: () => ajAuPanier(),
                  icon: Icon(Icons.shopping_cart, size: 16),
                  label: Text('Ajouter'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 36),
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
