import 'package:flutter/material.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  bool _isLoading = true;
  List<String> _playlists = [];

  @override
  void initState() {
    super.initState();
    _fetchPlaylists();
  }

  Future<void> _fetchPlaylists() async {
    // Simulate fetching data from local storage
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      _playlists = ["Top Hits 2024", "Relaxing Piano", "Workout Mix", "Classic Rock"];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Your Playlists", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.green, // Spotify green
              ),
            )
          : ListView.builder(
              itemCount: _playlists.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.music_note, color: Colors.green),
                  title: Text(
                    _playlists[index],
                    style: const TextStyle(color: Colors.white),
                  ),
                  onTap: () {},
                );
              },
            ),
    );
  }
}
