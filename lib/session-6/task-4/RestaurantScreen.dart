import 'package:flutter/material.dart';
import 'dbhelper.dart';

class RestaurantScreen1 extends StatefulWidget {
  const RestaurantScreen1({super.key});

  @override
  State<RestaurantScreen1> createState() => _RestaurantScreen1State();
}

class _RestaurantScreen1State extends State<RestaurantScreen1> {
  List<Map<String, dynamic>> _restaurants = [];

  @override
  void initState() {
    super.initState();
    _refreshRestaurants();
  }

  // Task 4: UI list automatically refreshes after database operations
  Future<void> _refreshRestaurants() async {
    final data = await DbHelper.instance.queryAllRows();
    setState(() {
      _restaurants = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Task 4: Auto Refresh")),
      body: ListView.builder(
        itemCount: _restaurants.length,
        itemBuilder: (context, index) {
          final restaurant = _restaurants[index];
          return ListTile(
            title: Text(restaurant[DbHelper.columnName]),
            subtitle: Text(restaurant[DbHelper.columnCuisine]),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                await DbHelper.instance.deletedata(restaurant[DbHelper.columnId]);
                // Refreshing UI immediately after database change
                _refreshRestaurants();
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await DbHelper.instance.insertdata({DbHelper.columnName: 'Auto Refresh Restro', DbHelper.columnCuisine: 'Dessert'});
          // Refreshing UI immediately after database change
          _refreshRestaurants();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
