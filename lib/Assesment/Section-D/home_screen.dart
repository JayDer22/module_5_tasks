import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'order_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;
  List<OrderModel> orderList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadOrders();
  }

  Future<void> loadOrders() async {
    setState(() => isLoading = true);
    final data = await dbHelper.getOrders();
    setState(() {
      orderList = data;
      isLoading = false;
    });
  }

  void showUpdateDialog(OrderModel order) {
    final quantityController = TextEditingController(text: order.quantity.toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Update ${order.productName}"),
        content: TextField(
          controller: quantityController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: "New Quantity",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              int? newQty = int.tryParse(quantityController.text);
              if (newQty != null) {
                order.quantity = newQty;
                await dbHelper.updateOrder(order);
                if (mounted) Navigator.pop(context);
                loadOrders(); // Immediate UI refresh
              }
            },
            child: const Text("Update"),
          ),
        ],
      ),
    );
  }

  Future<void> deleteOrder(int id) async {
    await dbHelper.deleteOrder(id);
    await loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Section D: Product Orders"),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : orderList.isEmpty
              ? const Center(child: Text("No records found."))
              : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: orderList.length,
                  itemBuilder: (context, index) {
                    final order = orderList[index];
                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(order.productName[0]),
                        ),
                        title: Text(
                          order.productName,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text("Quantity: ${order.quantity}"),
                        onTap: () => showUpdateDialog(order),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () => deleteOrder(order.id!),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
