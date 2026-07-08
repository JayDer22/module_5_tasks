import 'package:flutter/material.dart';

class RestaurantListScreen extends StatefulWidget {
  const RestaurantListScreen({super.key});

  @override
  State<RestaurantListScreen> createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  bool _isLoading = false;
  String? _error;
  List<String> _restaurants = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      // Simulate database call
      await Future.delayed(const Duration(seconds: 2));
      
      // Toggle these to test empty/error states
      bool simulateError = false;
      bool simulateEmpty = false;

      if (simulateError) throw Exception("Could not fetch data");
      
      setState(() {
        if (simulateEmpty) {
          _restaurants = [];
        } else {
          _restaurants = ["Dominos Pizza", "Burger King", "KFC", "Subway", "Pizza Hut"];
        }
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = "Something went wrong. Tap to refresh.";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Zomato - Restaurants"),
        backgroundColor: Colors.red,
      ),
      body: RefreshIndicator(
        onRefresh: _fetchData,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator(color: Colors.red))
            : _error != null
                ? SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      alignment: Alignment.center,
                      child: Text(_error!, style: const TextStyle(color: Colors.red)),
                    ),
                  )
                : _restaurants.isEmpty
                    ? SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.8,
                          alignment: Alignment.center,
                          child: const Text("No restaurants found near you."),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _restaurants.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: const Icon(Icons.restaurant, color: Colors.red),
                            title: Text(_restaurants[index]),
                            subtitle: const Text("Food delivery in 30 mins"),
                          );
                        },
                      ),
      ),
    );
  }
}
