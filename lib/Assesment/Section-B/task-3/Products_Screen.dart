import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  final List<Map<String, String>> products;
  final List<Map<String, String>> wishlist;

  const ProductsScreen({
    super.key,
    required this.products,
    required this.wishlist,
  });

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
      ),
      body: ListView.builder(
        itemCount: widget.products.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onLongPress: () {
              setState(() {
                if (!widget.wishlist.contains(widget.products[index])) {
                  widget.wishlist.add(widget.products[index]);
                }
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "${widget.products[index]["name"]} added to wishlist",
                  ),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                title: Text(widget.products[index]["name"]!),
                subtitle: Text(widget.products[index]["category"]!),
              ),
            ),
          );
        },
      ),
    );
  }
}