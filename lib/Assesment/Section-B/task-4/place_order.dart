import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'order_model.dart';

class PlaceOrder extends StatefulWidget {
  const PlaceOrder({super.key});

  @override
  State<PlaceOrder> createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController productController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  DatabaseHelper dbHelper = DatabaseHelper();

  @override
  void dispose() {
    productController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  void saveOrder() async {
    if (_formKey.currentState!.validate()) {
      OrderModel order = OrderModel(
        productName: productController.text,
        quantity: int.parse(quantityController.text),
      );

      await dbHelper.insertOrder(order);

      productController.clear();
      quantityController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Order Saved Successfully"),
        ),
      );

      Navigator.pushNamed(context, "/history");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Place Order"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              TextFormField(
                controller: productController,
                decoration: const InputDecoration(
                  labelText: "Product Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Product Name";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: quantityController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Quantity",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Quantity";
                  }

                  int? qty = int.tryParse(value);

                  if (qty == null || qty <= 0) {
                    return "Quantity must be greater than 0";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: saveOrder,
                child: const Text("Place Order"),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/history");
                },
                child: const Text("View Order History"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}