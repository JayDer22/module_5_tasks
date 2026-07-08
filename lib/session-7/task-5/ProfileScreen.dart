import 'package:flutter/material.dart';
import 'dbhelper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Task 5: Store data in a variable to minimize database calls
  Map<String, dynamic>? _cachedProfile;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadProfile(); // Initial fetch
  }

  Future<void> _loadProfile({bool forceRefresh = false}) async {
    // Task 5: Use cached data if available and refresh is not forced
    if (_cachedProfile != null && !forceRefresh) {
      print("Using cached profile data.");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final data = await DbHelper.instance.fetchUserProfile();
    
    setState(() {
      _cachedProfile = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User Profile")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(radius: 50, child: Text(_cachedProfile?[DbHelper.columnName][0] ?? "")),
                  const SizedBox(height: 20),
                  Text("Name: ${_cachedProfile?[DbHelper.columnName]}", style: const TextStyle(fontSize: 18)),
                  Text("Email: ${_cachedProfile?[DbHelper.columnEmail]}", style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () => _loadProfile(), // Uses cache
                    child: const Text("Show Profile (Cached)"),
                  ),
                  TextButton(
                    onPressed: () => _loadProfile(forceRefresh: true), // Force DB call
                    child: const Text("Explicit Refresh"),
                  ),
                ],
              ),
            ),
    );
  }
}
