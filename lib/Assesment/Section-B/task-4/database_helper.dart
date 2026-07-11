import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'order_model.dart';

class DatabaseHelper {
  static Database? database;

  Future<Database> getDB() async {
    if (database != null) return database!;

    database = await openDatabase(
      join(await getDatabasesPath(), "orders.db"),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE orders(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          product_name TEXT,
          quantity INTEGER
        )
        ''');
      },
    );

    return database!;
  }

  Future<void> insertOrder(OrderModel order) async {
    final db = await getDB();
    await db.insert("orders", order.toMap());
  }

  Future<List<OrderModel>> getOrders() async {
    final db = await getDB();

    final List<Map<String, dynamic>> maps =
    await db.query("orders");

    return List.generate(
      maps.length,
          (index) => OrderModel.fromMap(maps[index]),
    );
  }

  Future<void> deleteOrder(int id) async {
    final db = await getDB();

    await db.delete(
      "orders",
      where: "id=?",
      whereArgs: [id],
    );
  }
}