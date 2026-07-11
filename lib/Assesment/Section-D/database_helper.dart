import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'order_model.dart';

class DatabaseHelper {
  static final _databaseName = "orders_db.db";
  static final _databaseVersion = 1;

  static final table = 'orders';
  static final columnId = 'id';
  static final columnProductName = 'product_name';
  static final columnQuantity = 'quantity';

  static Database? _database;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    Database db = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
    await _checkAndInsertSampleData(db);
    return db;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnProductName TEXT NOT NULL,
            $columnQuantity INTEGER NOT NULL
          )
          ''');
  }

  Future<void> _checkAndInsertSampleData(Database db) async {
    // Check if table is empty
    var count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
    if (count == 0) {
      await db.insert(table, {columnProductName: 'Laptop', columnQuantity: 2});
      await db.insert(table, {columnProductName: 'Mobile', columnQuantity: 1});
      await db.insert(table, {columnProductName: 'Headphones', columnQuantity: 3});
    }
  }

  Future<List<OrderModel>> getOrders() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(table);
    return List.generate(maps.length, (i) => OrderModel.fromMap(maps[i]));
  }

  Future<int> updateOrder(OrderModel order) async {
    Database db = await instance.database;
    return await db.update(
      table,
      order.toMap(),
      where: '$columnId = ?',
      whereArgs: [order.id],
    );
  }

  Future<int> deleteOrder(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}
