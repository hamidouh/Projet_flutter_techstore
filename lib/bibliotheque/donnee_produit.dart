import 'package:techstore/models/product.dart';

class DataProduct {
  static List<Product> products = [
    Product(
      id: '1',
      title: 'Ordinateur Portable',
      description: 'PC portable avec écran 144Hz, RTX 4060',
      price: 1299.99,
      imageUrl: 'assets/images/pc.jpg',
    ),
    Product(
      id: '2',
      title: 'Clavier Mécanique RGB',
      description: 'Clavier mécanique avec switches bleus',
      price: 89.99,
      imageUrl: 'assets/images/clavier.jpg',
    ),
    Product(
      id: '3',
      title: 'Souris',
      description: 'Souris pour mieux travailler',
      price: 59.99,
      imageUrl: 'assets/images/souris.jpg',
    ),
    Product(
      id: '4',
      title: 'Imprimante Canon',
      description: 'Imprimante Canon en couleur ',
      price: 499.99,
      imageUrl: 'assets/images/imprimanteMuni.jpg',
    ),
    Product(
      id: '5',
      title: 'Casque Audio',
      description: 'Casque avec micro détachable',
      price: 79.99,
      imageUrl: 'assets/images/munibaf.jpg',
    ),
    Product(
      id: '6',
      title: 'Disque SSD 1TB',
      description: 'SSD NVMe 1TB avec vitesse de lecture',
      price: 129.99,
      imageUrl: 'assets/images/disque.jpg',
    ),
  ];
}
