import 'package:flutter/material.dart';
import 'dbhelper.dart';

class SpotifyPlaylistScreen extends StatefulWidget {
  const SpotifyPlaylistScreen({super.key});

  @override
  State<SpotifyPlaylistScreen> createState() => _SpotifyPlaylistScreenState();
}

class _SpotifyPlaylistScreenState extends State<SpotifyPlaylistScreen> {
  List<Map<String, dynamic>> _playlists = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final data = await DbHelper.instance.queryPlaylists();
    setState(() {
      _playlists = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Your Library", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.green))
          : _playlists.isEmpty
              ? const Center(
                  child: Text(
                    "No items found", // Task 3: Display message instead of blank screen
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                )
              : ListView.builder(
                  itemCount: _playlists.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.music_note, color: Colors.green),
                      title: Text(
                        _playlists[index][DbHelper.columnName],
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
    );
  }
}
