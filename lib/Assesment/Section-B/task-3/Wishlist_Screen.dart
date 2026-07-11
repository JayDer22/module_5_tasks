import 'package:flutter/material.dart';

class WishlistScreen extends StatefulWidget {
  final List<Map<String, String>> wishlist;

  const WishlistScreen({
    super.key,
    required this.wishlist,
  });

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wishlist"),
      ),
      body: widget.wishlist.isEmpty
          ? const Center(
        child: Text("Wishlist is Empty"),
      )
          : ListView.builder(
        itemCount: widget.wishlist.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text(widget.wishlist[index]["name"]!),
              subtitle: Text(widget.wishlist[index]["category"]!),
            ),
          );
        },
      ),
    );
  }
}