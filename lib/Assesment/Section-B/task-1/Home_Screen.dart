import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final List<Map<String, String>> products;

  const HomeScreen({
    super.key,
    required this.products,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: ListView.builder(
        itemCount: widget.products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(widget.products[index]["product"]!),
            subtitle: Text(widget.products[index]["category"]!),
            trailing: Text("₹${widget.products[index]["price"]}"),
          );
        },
      ),
    );
  }
}