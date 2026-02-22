import 'package:flutter/material.dart';
import 'package:techstore/models/cartitem.dart';

class CartWidget extends StatelessWidget {
  final CartItem item;
  final Function onIncrease;
  final Function onDecrease;
  final Function onRemove;

  const CartWidget({
    super.key,
    required this.item,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        leading: CircleAvatar(child: Text('${item.quantity}')),
        title: Text(item.title),
        subtitle: Text(
          '${item.price} € * ${item.quantity} = ${item.subtotal.toStringAsFixed(2)} €',
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.remove, size: 20),
              onPressed: () => onDecrease(),
            ),
            IconButton(
              icon: Icon(Icons.add, size: 20),
              onPressed: () => onIncrease(),
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => onRemove(),
            ),
          ],
        ),
      ),
    );
  }
}
