import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'movie.dart';

class Dbhelper {
  static final _databasename = "movies.db";
  static final _databaseversion = 1;

  static final table = 'moviestb';
  static final columnid = 'id';
  static final columntitle = 'title';
  static final columngenre = 'genre';
  static final columnisWatched = 'isWatched';

  static Database? _database;

  Dbhelper._privateConstructor();

  static final Dbhelper instance = Dbhelper._privateConstructor();

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnid INTEGER PRIMARY KEY AUTOINCREMENT,
            $columntitle TEXT NOT NULL,
            $columngenre TEXT NOT NULL,
            $columnisWatched INTEGER NOT NULL
          )
          ''');
  }

  Future<Database> get database async => _database ??= await _initDatabase();

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databasename);
    return await openDatabase(path,
        version: _databaseversion, onCreate: _onCreate);
  }

  // Insert Movie using Map as per user structure
  Future<int> insertdata(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  // View all movies
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  // Delete movie
  Future<int> deletedata(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnid = ?', whereArgs: [id]);
  }
}
