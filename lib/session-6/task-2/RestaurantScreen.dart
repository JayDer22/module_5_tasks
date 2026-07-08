import 'package:flutter/material.dart';
import 'dbhelper.dart';

class RestaurantScreen3 extends StatefulWidget {
  const RestaurantScreen3({super.key});

  @override
  State<RestaurantScreen3> createState() => _RestaurantScreen3State();
}

class _RestaurantScreen3State extends State<RestaurantScreen3> {
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

  void _showEditDialog(Map<String, dynamic> restaurant) {
    final nameController = TextEditingController(text: restaurant[DbHelper.columnName]);
    final cuisineController = TextEditingController(text: restaurant[DbHelper.columnCuisine]);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Restaurant"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: "Name")),
            TextField(controller: cuisineController, decoration: const InputDecoration(labelText: "Cuisine")),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              await DbHelper.instance.updatedata({
                DbHelper.columnId: restaurant[DbHelper.columnId],
                DbHelper.columnName: nameController.text,
                DbHelper.columnCuisine: cuisineController.text,
              });
              Navigator.pop(context);
              _refreshRestaurants();
            },
            child: const Text("Update"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Task 2: Edit Restaurant")),
      body: ListView.builder(
        itemCount: _restaurants.length,
        itemBuilder: (context, index) {
          final restaurant = _restaurants[index];
          return ListTile(
            title: Text(restaurant[DbHelper.columnName]),
            subtitle: Text(restaurant[DbHelper.columnCuisine]),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => _showEditDialog(restaurant),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await DbHelper.instance.insertdata({DbHelper.columnName: 'Restro', DbHelper.columnCuisine: 'Indian'});
          _refreshRestaurants();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
