import 'package:flutter/material.dart';
import 'Products_Screen.dart';
import 'Wishlist_Screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  List<Map<String, String>> products = [
    {"name": "Laptop", "category": "Electronics"},
    {"name": "Phone", "category": "Electronics"},
    {"name": "Shoes", "category": "Fashion"},
    {"name": "Watch", "category": "Accessories"},
    {"name": "Backpack", "category": "Bags"},
  ];

  List<Map<String, String>> wishlist = [];

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      ProductsScreen(
        products: products,
        wishlist: wishlist,
      ),
      WishlistScreen(
        wishlist: wishlist,
      ),
    ];

    return Scaffold(
      body: screens[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: "Products",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Wishlist",
          ),
        ],
      ),
    );
  }
}