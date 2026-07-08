import 'package:flutter/material.dart';
import 'dbhelper.dart';

class RestaurantFetchScreen extends StatelessWidget {
  const RestaurantFetchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Task 1: Safe Fetch")),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // This triggers the try-catch fetch logic
            await DbHelper.instance.fetchRestaurantsAsync();
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Fetch attempted. Check console.")),
              );
            }
          },
          child: const Text("Fetch Restaurants (Console)"),
        ),
      ),
    );
  }
}
