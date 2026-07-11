import 'package:flutter/material.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {

  List<Map<String, dynamic>> products = [
    {
      "name": "Laptop",
      "category": "Electronics",
      "price": 55000,
    },
    {
      "name": "Mobile",
      "category": "Electronics",
      "price": 25000,
    },
    {
      "name": "Headphones",
      "category": "Accessories",
      "price": 3000,
    },
    {
      "name": "Shoes",
      "category": "Fashion",
      "price": 2000,
    },
    {
      "name": "Watch",
      "category": "Accessories",
      "price": 4500,
    },
    {
      "name": "Backpack",
      "category": "Bags",
      "price": 1800,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Browse Products"),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          var product = products[index];

          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text(product["name"]),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Category: ${product["category"]}"),
                  Text("Price: ₹${product["price"]}"),
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  "/detail",
                  arguments: product,
                );
              },
            ),
          );
        },
      ),
    );
  }
}