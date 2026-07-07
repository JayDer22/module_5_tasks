import 'package:flutter/material.dart';
import 'dbhelper.dart';
import 'playlist.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  final DbHelper _dbHelper = DbHelper.instance;
  late Future<List<Playlist>> _playlistsFuture;

  @override
  void initState() {
    super.initState();
    _refreshPlaylists();
  }

  void _refreshPlaylists() {
    setState(() {
      _playlistsFuture = _loadPlaylists();
    });
  }

  Future<List<Playlist>> _loadPlaylists() async {
    final List<Map<String, dynamic>> maps = await _dbHelper.queryAllRows();
    return List.generate(maps.length, (i) => Playlist.fromMap(maps[i]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Playlists'),
      ),
      body: FutureBuilder<List<Playlist>>(
        future: _playlistsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No playlists found.'));
          }

          final playlists = snapshot.data!;
          return ListView.builder(
            itemCount: playlists.length,
            itemBuilder: (context, index) {
              final playlist = playlists[index];
              return ListTile(
                title: Text(playlist.name),
                subtitle: Text('${playlist.songCount} songs'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    await _dbHelper.deletedata(playlist.id!);
                    _refreshPlaylists();
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Create dummy playlist and convert to Map for insertdata
          final newPlaylist = Playlist(
            name: 'New Playlist ${DateTime.now().second}',
            songCount: 0,
          );
          await _dbHelper.insertdata(newPlaylist.toMap());
          _refreshPlaylists();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
