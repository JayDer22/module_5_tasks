import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'product_model.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  DatabaseHelper dbHelper = DatabaseHelper();

  bool isSaved = false;

  Map<String, dynamic>? product;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    product =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    checkWishlist();
  }

  void checkWishlist() async {
    bool result = await dbHelper.checkProduct(product!["name"]);

    setState(() {
      isSaved = result;
    });
  }

  void saveOrRemove() async {
    if (!isSaved) {
      ProductModel newProduct = ProductModel(
        name: product!["name"],
        category: product!["category"],
        price: product!["price"],
      );

      await dbHelper.insertProduct(newProduct);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Product Saved"),
        ),
      );
    } else {
      await dbHelper.deleteProduct(product!["name"]);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Product Removed"),
        ),
      );
    }

    checkWishlist();
  }

  @override
  Widget build(BuildContext context) {
    if (product == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "Name : ${product!["name"]}",
              style: const TextStyle(fontSize: 20),
            ),

            const SizedBox(height: 15),

            Text(
              "Category : ${product!["category"]}",
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 15),

            Text(
              "Price : ₹${product!["price"]}",
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: saveOrRemove,
                child: Text(
                  isSaved
                      ? "Remove from Wishlist"
                      : "Save to Wishlist",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}