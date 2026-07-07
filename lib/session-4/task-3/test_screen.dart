import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'playlist.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final dbHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Task 3: Database Test")),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await dbHelper.insertdata(
              Playlist(name: "My Hits", songCount: 15).toMap(),
            );
            
            final list = await dbHelper.queryAllRows();
            print("Total Playlists: ${list.length}");
            
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Added! Total playlists: ${list.length}")),
            );
          },
          child: const Text("Add & Count Playlists"),
        ),
      ),
    );
  }
}
