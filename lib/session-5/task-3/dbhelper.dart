import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static final _databaseName = "orders.db";
  static final _databaseVersion = 1;

  static final table = 'orders';
  static final columnId = '_id';
  static final columnName = 'order_name';

  static Database? _database;

  DbHelper._privateConstructor();
  static final DbHelper instance = DbHelper._privateConstructor();

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnName TEXT NOT NULL
          )
          ''');
    
    // Adding some initial data
    await db.insert(table, {columnName: 'Zomato: Pizza Margherita'});
    await db.insert(table, {columnName: 'Zomato: Paneer Tikka'});
  }

  Future<Database> get database async => _database ??= await _initDatabase();

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }
}
