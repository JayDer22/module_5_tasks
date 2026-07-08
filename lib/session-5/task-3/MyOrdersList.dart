import 'package:flutter/material.dart';
import 'dbhelper.dart';

class MyOrdersList extends StatefulWidget {
  const MyOrdersList({super.key});

  @override
  State<MyOrdersList> createState() => _MyOrdersListState();
}

class _MyOrdersListState extends State<MyOrdersList> {
  List<Map<String, dynamic>> _orders = [];

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    final data = await DbHelper.instance.queryAllRows();
    setState(() {
      _orders = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Zomato Orders")),
      body: _orders.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _orders.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.fastfood),
                  title: Text(_orders[index][DbHelper.columnName]),
                );
              },
            ),
    );
  }
}
