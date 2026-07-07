import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'playlist.dart';

class DbHelper {
  static final _databaseName = "music_app.db";
  static final _databaseVersion = 1;

  static const String tableName = 'playlists';
  static const String columnId = 'id';
  static const String columnName = 'name';
  static const String columnSongCount = 'songCount';

  static Database? _database;

  DbHelper._privateConstructor();

  static final DbHelper instance = DbHelper._privateConstructor();

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tableName (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnName TEXT NOT NULL,
            $columnSongCount INTEGER NOT NULL
          )
          ''');
  }

  Future<Database> get database async => _database ??= await _initDatabase();

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // Insert data using Map structure as requested
  Future<int> insertdata(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tableName, row);
  }

  // View all playlists
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(tableName);
  }

  // Delete playlist
  Future<int> deletedata(int id) async {
    Database db = await instance.database;
    return await db.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}
