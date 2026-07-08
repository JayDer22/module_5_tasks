import 'package:flutter/material.dart';
import '../task-3/dbhelper.dart';

class MyOrdersListRefactored extends StatefulWidget {
  const MyOrdersListRefactored({super.key});

  @override
  State<MyOrdersListRefactored> createState() => _MyOrdersListRefactoredState();
}

class _MyOrdersListRefactoredState extends State<MyOrdersListRefactored> {
  List<String> _orders = [];

  @override
  void initState() {
    super.initState();
    // Initial load
    _updateUI();
  }

  // Refactored fetch logic
  Future<List<String>> fetchOrdersAsync() async {
    final data = await DbHelper.instance.queryAllRows();
    // Converting List<Map> to List<String> as per constraint
    return data.map((item) => item[DbHelper.columnName] as String).toList();
  }

  Future<void> _updateUI() async {
    final orders = await fetchOrdersAsync();
    setState(() {
      _orders = orders;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Task 5: Refactored Orders")),
      body: _orders.isEmpty
          ? const Center(child: Text("No orders found."))
          : ListView.builder(
              itemCount: _orders.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.shopping_bag),
                  title: Text(_orders[index]),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Demonstration of updating after insert
          await DbHelper.instance.database.then((db) => db.insert(
            DbHelper.table, 
            {DbHelper.columnName: 'Zomato: New Order ${DateTime.now().second}'}
          ));
          
          // Refreshing the list after insert
          await _updateUI();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
