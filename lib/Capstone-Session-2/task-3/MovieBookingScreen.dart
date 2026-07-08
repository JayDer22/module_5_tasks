import 'package:flutter/material.dart';

class MovieBookingScreen extends StatefulWidget {
  const MovieBookingScreen({super.key});

  @override
  State<MovieBookingScreen> createState() => _MovieBookingScreenState();
}

class _MovieBookingScreenState extends State<MovieBookingScreen> {
  bool _isLoading = false;
  String? _errorMessage;
  List<String> _movies = [];

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Simulate local data fetch that might fail
      await Future.delayed(const Duration(seconds: 2));
      
      // Simulating a failure condition
      throw Exception("Database connection failed");

      // setState(() {
      //   _movies = ["Inception", "Interstellar", "The Dark Knight"];
      //   _isLoading = false;
      // });
    } catch (e) {
      setState(() {
        _errorMessage = "Failed to load movies. Please check your connection.";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("BookMyShow - Movies")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, size: 60, color: Colors.red),
                      const SizedBox(height: 10),
                      Text(_errorMessage!, textAlign: TextAlign.center),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _loadMovies,
                        child: const Text("Retry"),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: _movies.length,
                  itemBuilder: (context, index) {
                    return ListTile(title: Text(_movies[index]));
                  },
                ),
    );
  }
}
