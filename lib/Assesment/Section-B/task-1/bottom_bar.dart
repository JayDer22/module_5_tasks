import 'package:flutter/material.dart';
import 'Home_Screen.dart';
import 'Add_List.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int currentIndex = 0;

  List<Map<String, String>> products = [];

  @override
  Widget build(BuildContext context) {

    List<Widget> screens = [
      HomeScreen(products: products),
      AddList(
        onAdd: (product, category, price) {
          setState(() {
            products.add({
              "product": product,
              "category": category,
              "price": price,
            });
          });

          currentIndex = 0;
        },
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
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "Add",
          ),
        ],
      ),

    );
  }
}