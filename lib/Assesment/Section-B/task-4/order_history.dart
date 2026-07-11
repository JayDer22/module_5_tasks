import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'order_model.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  DatabaseHelper dbHelper = DatabaseHelper();

  List<OrderModel> orders = [];

  @override
  void initState() {
    super.initState();
    loadOrders();
  }

  void loadOrders() async {
    orders = await dbHelper.getOrders();

    setState(() {});
  }

  void deleteOrder(int id) async {
    await dbHelper.deleteOrder(id);

    loadOrders();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Order Deleted"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order History"),
      ),
      body: orders.isEmpty
          ? const Center(
        child: Text("No Orders Found"),
      )
          : ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text(orders[index].productName),
              subtitle:
              Text("Quantity : ${orders[index].quantity}"),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  deleteOrder(orders[index].id!);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}