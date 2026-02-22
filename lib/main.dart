import 'package:flutter/material.dart';
import 'package:techstore/screens/homepage.dart';
import 'package:techstore/screens/cart_page.dart';
import 'package:techstore/screens/admin_page.dart';
import 'package:techstore/models/product.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // On utilise un ValueNotifier pour stocker l'état du thème
  final ValueNotifier<ThemeMode> _notifier = ValueNotifier(ThemeMode.light);
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: _notifier,
      builder: (_, mode, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'TechStore',

          // 1. Gestion du mode
          themeMode: mode,

          // 2. Thème Clair
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            colorSchemeSeed: Colors.green,
            scaffoldBackgroundColor: const Color(0xFFF8F9FA),
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 0,
              centerTitle: true,
            ),
          ),
          // 3. Thème Sombre
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            colorSchemeSeed: Colors.green,
            scaffoldBackgroundColor: const Color(0xFF121212),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF1E1E1E),
              foregroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
            ),
            //cardTheme: const CardTheme(color: Color(0xFF1E1E1E), elevation: 2),
          ),
          // On passe le notifier à la page d'accueil pour pouvoir changer le thème depuis l'UI
          home: Homepage(themeNotifier: _notifier),
          routes: {
            '/cart': (context) =>
                CartPage(cartItems: [], onUpdateCart: (List<Product> p1) {}),
            '/admin': (context) => AdminPage(),
          },
        );
      },
    );
  }
}
