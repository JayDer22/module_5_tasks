import 'package:flutter/material.dart';
import 'dbhelper.dart';

class SavedPlaylistsScreen extends StatefulWidget {
  const SavedPlaylistsScreen({super.key});

  @override
  State<SavedPlaylistsScreen> createState() => _SavedPlaylistsScreenState();
}

class _SavedPlaylistsScreenState extends State<SavedPlaylistsScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> _playlists = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _refreshPlaylists();
  }

  Future<void> _refreshPlaylists() async {
    final data = await DbHelper.instance.queryAllRows();
    setState(() {
      _playlists = data;
    });
  }

  Future<void> _addPlaylist() async {
    if (_controller.text.isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    // Asynchronous insert
    await DbHelper.instance.insertdata({
      DbHelper.columnName: _controller.text,
    });

    _controller.clear();
    await _refreshPlaylists();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Async Playlist Manager")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(hintText: "Enter playlist name"),
                  ),
                ),
                const SizedBox(width: 10),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _addPlaylist,
                        child: const Text("Add"),
                      ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _playlists.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_playlists[index][DbHelper.columnName]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
