import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'product_model.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {

  DatabaseHelper dbHelper = DatabaseHelper();

  List<ProductModel> wishlist = [];

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  void loadProducts() async {
    wishlist = await dbHelper.getProducts();

    setState(() {});
  }

  void deleteProduct(int id) async {
    await dbHelper.deleteProduct(id);

    loadProducts();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Product Removed"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wishlist"),
      ),
      body: wishlist.isEmpty
          ? const Center(
        child: Text("Wishlist is Empty"),
      )
          : ListView.builder(
        itemCount: wishlist.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text(wishlist[index].name),
              subtitle: Text(
                  "${wishlist[index].category}\n₹${wishlist[index].price}"),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  deleteProduct(wishlist[index].id!);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}