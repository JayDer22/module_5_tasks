import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static final _databaseName = "task3.db";
  static final table = 'playlists';
  static final columnName = 'name';

  static Database? _database;
  DbHelper._privateConstructor();
  static final DbHelper instance = DbHelper._privateConstructor();

  Future<Database> get database async => _database ??= await _initDatabase();

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path, version: 1, onCreate: (db, v) async {
      await db.execute('CREATE TABLE $table (id INTEGER PRIMARY KEY, $columnName TEXT)');
      // We leave it empty to simulate empty state
    });
  }

  Future<List<Map<String, dynamic>>> queryPlaylists() async {
    Database db = await instance.database;
    return await db.query(table);
  }
}
