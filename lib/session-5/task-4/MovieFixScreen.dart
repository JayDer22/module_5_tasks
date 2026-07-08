import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

// Simple DbHelper for Task 4 following the user's structure
class MovieDbHelper {
  static final _databaseName = "movies_fix.db";
  static final table = 'movies';
  static final columnId = 'id';
  static final columnTitle = 'title';

  static Database? _database;
  MovieDbHelper._privateConstructor();
  static final MovieDbHelper instance = MovieDbHelper._privateConstructor();

  Future<Database> get database async => _database ??= await _initDatabase();

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path, version: 1, onCreate: (db, v) async {
      await db.execute('CREATE TABLE $table ($columnId INTEGER PRIMARY KEY, $columnTitle TEXT)');
    });
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await instance.database;
    return await db.query(table);
  }
}

class MovieFixScreen extends StatefulWidget {
  const MovieFixScreen({super.key});

  @override
  State<MovieFixScreen> createState() => _MovieFixScreenState();
}

class _MovieFixScreenState extends State<MovieFixScreen> {
  final TextEditingController movieController = TextEditingController();
  List<Map<String, dynamic>> _movieList = [];

  @override
  void initState() {
    super.initState();
    _refreshMovies();
  }

  Future<void> _refreshMovies() async {
    final data = await MovieDbHelper.instance.queryAll();
    setState(() {
      _movieList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Task 4: Movie Insert Fix")),
      body: Column(
        children: [
          TextField(controller: movieController),
          ElevatedButton(
            // FIXED CODE BELOW
            onPressed: () async {
              // 1. Await the insert operation
              await MovieDbHelper.instance.insert({'title': movieController.text});
              // 2. Refresh the data source
              await _refreshMovies();
              // 3. Clear the text field
              movieController.clear();
              // setState is called inside _refreshMovies
            },
            child: const Text("Add Movie"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _movieList.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(_movieList[index]['title']),
              ),
            ),
          )
        ],
      ),
    );
  }
}
