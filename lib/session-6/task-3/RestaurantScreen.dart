import 'package:flutter/material.dart';
import 'dbhelper.dart';

class RestaurantScreen2 extends StatefulWidget {
  const RestaurantScreen2({super.key});

  @override
  State<RestaurantScreen2> createState() => _RestaurantScreen2State();
}

class _RestaurantScreen2State extends State<RestaurantScreen2> {
  List<Map<String, dynamic>> _restaurants = [];

  @override
  void initState() {
    super.initState();
    _refreshRestaurants();
  }

  Future<void> _refreshRestaurants() async {
    final data = await DbHelper.instance.queryAllRows();
    setState(() {
      _restaurants = data;
    });
  }

  void _deleteWithUndo(int index) async {
    final deletedItem = _restaurants[index];
    final id = deletedItem[DbHelper.columnId];

    await DbHelper.instance.deletedata(id);
    _refreshRestaurants();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${deletedItem[DbHelper.columnName]} deleted"),
        action: SnackBarAction(
          label: "UNDO",
          onPressed: () async {
            await DbHelper.instance.insertdata({
              DbHelper.columnName: deletedItem[DbHelper.columnName],
              DbHelper.columnCuisine: deletedItem[DbHelper.columnCuisine],
            });
            _refreshRestaurants();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Task 3: SnackBar Undo")),
      body: ListView.builder(
        itemCount: _restaurants.length,
        itemBuilder: (context, index) {
          final restaurant = _restaurants[index];
          return ListTile(
            title: Text(restaurant[DbHelper.columnName]),
            subtitle: Text(restaurant[DbHelper.columnCuisine]),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteWithUndo(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await DbHelper.instance.insertdata({DbHelper.columnName: 'Undo Restro', DbHelper.columnCuisine: 'Fast Food'});
          _refreshRestaurants();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
