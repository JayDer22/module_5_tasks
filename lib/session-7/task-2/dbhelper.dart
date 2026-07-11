import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static final _databaseName = "task2.db";
  static final table = 'products';
  static final columnName = 'name';
  static final columnPrice = 'price';

  static Database? _database;

  DbHelper._privateConstructor();

  static final DbHelper instance = DbHelper._privateConstructor();

  Future<Database> get database async => _database ??= await _initDatabase();

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, v) async {
        await db.execute(
          'CREATE TABLE $table (id INTEGER PRIMARY KEY, $columnName TEXT, $columnPrice TEXT)',
        );
        await db.insert(table, {
          columnName: 'iPhone 15',
          columnPrice: '79,900',
        });
        await db.insert(table, {
          columnName: 'MacBook Air',
          columnPrice: '99,900',
        });
      },
    );
  }

  Future<List<Map<String, dynamic>>> queryProducts() async {
    Database db = await instance.database;
    // Artificial delay to show CircularProgressIndicator
    await Future.delayed(const Duration(seconds: 2));
    return await db.query(table);
  }
}
