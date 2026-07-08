import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static final _databaseName = "restaurants_t3.db";
  static final table = 'restaurants';
  static final columnId = '_id';
  static final columnName = 'name';
  static final columnCuisine = 'cuisine';

  static Database? _database;
  DbHelper._privateConstructor();
  static final DbHelper instance = DbHelper._privateConstructor();

  Future<Database> get database async => _database ??= await _initDatabase();

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path, version: 1, onCreate: (db, v) async {
      await db.execute('CREATE TABLE $table ($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnName TEXT, $columnCuisine TEXT)');
    });
  }

  Future<int> insertdata(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<int> deletedata(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}
