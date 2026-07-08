import 'package:flutter/material.dart';
import 'dbhelper.dart';

class RestaurantScreen extends StatefulWidget {
  const RestaurantScreen({super.key});

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Task 1: Swipe to Delete")),
      body: ListView.builder(
        itemCount: _restaurants.length,
        itemBuilder: (context, index) {
          final restaurant = _restaurants[index];
          return Dismissible(
            key: Key(restaurant[DbHelper.columnId].toString()),
            direction: DismissDirection.endToStart,
            background: Container(color: Colors.red, alignment: Alignment.centerRight, child: const Icon(Icons.delete, color: Colors.white)),
            onDismissed: (direction) async {
              await DbHelper.instance.deletedata(restaurant[DbHelper.columnId]);
              _refreshRestaurants();
            },
            child: ListTile(
              title: Text(restaurant[DbHelper.columnName]),
              subtitle: Text(restaurant[DbHelper.columnCuisine]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await DbHelper.instance.insertdata({DbHelper.columnName: 'New Restro', DbHelper.columnCuisine: 'Italian'});
          _refreshRestaurants();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
