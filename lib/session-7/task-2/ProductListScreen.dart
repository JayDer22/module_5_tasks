import 'package:flutter/material.dart';
import 'dbhelper.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Map<String, dynamic>> _products = [];
  bool _isLoading = true; // Task 2: Loading state

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final data = await DbHelper.instance.queryProducts();
    setState(() {
      _products = data;
      _isLoading = false; // Task 2: Hide indicator once loaded
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flipkart Products")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator()) // Task 2: Show indicator
          : ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: const Icon(Icons.shopping_bag, color: Colors.blue),
                    title: Text(_products[index][DbHelper.columnName]),
                    subtitle: Text(_products[index][DbHelper.columnPrice]),
                    trailing: const Text("View Details", style: TextStyle(color: Colors.blue)),
                  ),
                );
              },
            ),
    );
  }
}
