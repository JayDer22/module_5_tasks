import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static final _databaseName = "task5.db";
  static final table = 'user_profile';
  static final columnName = 'name';
  static final columnEmail = 'email';

  static Database? _database;
  DbHelper._privateConstructor();
  static final DbHelper instance = DbHelper._privateConstructor();

  Future<Database> get database async => _database ??= await _initDatabase();

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path, version: 1, onCreate: (db, v) async {
      await db.execute('CREATE TABLE $table (id INTEGER PRIMARY KEY, $columnName TEXT, $columnEmail TEXT)');
      await db.insert(table, {columnName: 'John Doe', columnEmail: 'john@example.com'});
    });
  }

  Future<Map<String, dynamic>> fetchUserProfile() async {
    print("DATABASE CALL: Fetching profile from DB...");
    final db = await instance.database;
    final result = await db.query(table, where: 'id = ?', whereArgs: [1]);
    return result.first;
  }
}
