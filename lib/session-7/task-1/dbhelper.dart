import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static final _databaseName = "task1.db";
  static final table = 'restaurants';
  static final columnId = '_id';
  static final columnName = 'name';

  static Database? _database;
  DbHelper._privateConstructor();
  static final DbHelper instance = DbHelper._privateConstructor();

  Future<Database> get database async => _database ??= await _initDatabase();

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path, version: 1, onCreate: (db, v) async {
      await db.execute('CREATE TABLE $table ($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnName TEXT)');
      await db.insert(table, {columnName: 'Pizza Hut'});
    });
  }

  // Task 1: Wrapped in Future with try-catch
  Future<List<Map<String, dynamic>>> fetchRestaurantsAsync() async {
    try {
      Database db = await instance.database;
      final data = await db.query(table);
      print("Data fetched successfully: $data");
      return data;
    } catch (e) {
      print("Error fetching restaurants: $e");
      return [];
    }
  }
}
