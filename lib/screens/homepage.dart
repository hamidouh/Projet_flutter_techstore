import 'package:flutter/material.dart';
import 'package:techstore/bibliotheque/donnee_produit.dart';
import 'package:techstore/models/product.dart';
import 'package:techstore/screens/cart_page.dart';
import 'package:techstore/widgets/product_item_page.dart';
import 'package:techstore/widgets/product_carousel_page.dart';
import '../screens/product_detail_page.dart';

class Homepage extends StatefulWidget {
  // Le contrôleur de thème passé depuis le main.dart
  final ValueNotifier<ThemeMode> themeNotifier;

  const Homepage({super.key, required this.themeNotifier});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final List<Product> _products = DataProduct.products;
  List<Product> _cartItems = [];
  List<Product> _magasinProducts = [];

  @override
  void initState() {
    super.initState();
    // On récupère les 3 premiers produits pour le carrousel
    _magasinProducts = _products.take(3).toList();
  }

  // Fonction pour ajouter au panier
  void ajoutAuPanier(Product product) {
    setState(() {
      _cartItems.add(product);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.title} ajouté au panier'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // Navigation vers le détail
  void navigToProductDetail(Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailPage(
          products: product,
          ajAuPanier: () => ajoutAuPanier(product),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TechStore',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          // --- BOUTON DE CHANGEMENT DE THÈME ---
          IconButton(
            icon: Icon(
              widget.themeNotifier.value == ThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            onPressed: () {
              setState(() {
                // Change la valeur globale et rafraîchit l'icône
                widget.themeNotifier.value =
                    widget.themeNotifier.value == ThemeMode.light
                    ? ThemeMode.dark
                    : ThemeMode.light;
              });
            },
          ),
          // --- BOUTON PANIER AVEC BADGE ---
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartPage(
                        cartItems: _cartItems,
                        onUpdateCart: (items) {
                          setState(() {
                            _cartItems = items;
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
              if (_cartItems.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${_cartItems.length}',
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: Theme.of(context).brightness == Brightness.light
                      ? [Colors.green, Colors.orange]
                      : [Colors.green.shade900, Colors.orange.shade900],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: const Center(
                child: Text(
                  'TechStore',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            _buildDrawerItem(
              Icons.home,
              'Accueil',
              () => Navigator.pop(context),
            ),
            _buildDrawerItem(Icons.shopping_cart, 'Panier', () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(
                    cartItems: _cartItems,
                    onUpdateCart: (items) {
                      setState(() {
                        _cartItems = items;
                      });
                    },
                  ),
                ),
              );
            }),
            _buildDrawerItem(Icons.admin_panel_settings, 'Administration', () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/admin');
            }),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'À la une',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            ProductCarousel(magasinProducts: _magasinProducts),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Catalogue',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            // Utilisation d'un GridView sans hauteur fixe pour éviter les problèmes de scroll
            GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              shrinkWrap: true, // Important pour le SingleChildScrollView
              physics:
                  const NeverScrollableScrollPhysics(), // Désactive le scroll du GridView lui-même
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: _products.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => navigToProductDetail(_products[index]),
                  child: ProductItem(
                    product: _products[index],
                    ajAuPanier: () => ajoutAuPanier(_products[index]),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Petit Helper pour les items du Drawer
  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        tileColor: Theme.of(context).brightness == Brightness.light
            ? Colors.grey[100]
            : Colors.grey[900],
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(title),
        trailing: const Icon(Icons.arrow_right),
        onTap: onTap,
      ),
    );
  }
}
