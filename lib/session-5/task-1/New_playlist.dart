import 'package:flutter/material.dart';
import '../../session-4/task-3/database_helper.dart';

class NewPlaylist extends StatefulWidget {
  const NewPlaylist({super.key});

  @override
  State<NewPlaylist> createState() => _NewPlaylistState();
}

class _NewPlaylistState extends State<NewPlaylist> {
  List<Map<String, dynamic>> playlistnm = [];

  @override
  void initState() {
    super.initState();
    loadPlaylists();
  }

  Future<void> loadPlaylists() async {
    final data = await DatabaseHelper.instance.queryAllRows();
    setState(() {
      playlistnm = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Playlists")),
      body: playlistnm.isEmpty
          ? const Center(child: Text("No playlists yet. Add one!"))
          : ListView.builder(
              itemCount: playlistnm.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.playlist_play),
                  title: Text(playlistnm[index][DatabaseHelper.columnName] ?? "Unknown"),
                  subtitle: Text("${playlistnm[index][DatabaseHelper.columnSongCount] ?? 0} songs"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      int id = playlistnm[index][DatabaseHelper.columnId];
                      await DatabaseHelper.instance.deletedata(id);
                      loadPlaylists(); // Refresh list
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddPlaylistScreen(),
            ),
          );
          loadPlaylists(); // Refresh list after returning
        },
      ),
    );
  }
}

class AddPlaylistScreen extends StatefulWidget {
  const AddPlaylistScreen({super.key});

  @override
  State<AddPlaylistScreen> createState() => _AddPlaylistScreenState();
}

class _AddPlaylistScreenState extends State<AddPlaylistScreen> {
  final TextEditingController listnm = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add New Playlist")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: listnm,
              decoration: const InputDecoration(
                labelText: "Playlist name",
                hintText: "Enter your Playlist name...",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (listnm.text.isNotEmpty) {
                  // We MUST include songCount because it is NOT NULL in the database
                  await DatabaseHelper.instance.insertdata({
                    DatabaseHelper.columnName: listnm.text,
                    DatabaseHelper.columnSongCount: 0, // Default to 0 songs
                  });
                  if (mounted) Navigator.pop(context);
                }
              },
              child: const Text("Add Playlist"),
            )
          ],
        ),
      ),
    );
  }
}
