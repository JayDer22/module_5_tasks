import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'product_model.dart';

class DatabaseHelper {
  static Database? database;

  Future<Database> getDatabase() async {
    if (database != null) {
      return database!;
    }

    database = await openDatabase(
      join(await getDatabasesPath(), "wishlist.db"),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE wishlist(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          category TEXT,
          price INTEGER
        )
        ''');
      },
    );

    return database!;
  }

  Future<void> insertProduct(ProductModel product) async {
    final db = await getDatabase();

    await db.insert(
      "wishlist",
      product.toMap(),
    );
  }

  Future<List<ProductModel>> getProducts() async {
    final db = await getDatabase();

    List<Map<String, dynamic>> maps =
    await db.query("wishlist");

    return List.generate(
      maps.length,
          (index) => ProductModel.fromMap(maps[index]),
    );
  }

  Future<void> deleteProduct(int id) async {
    final db = await getDatabase();

    await db.delete(
      "wishlist",
      where: "id=?",
      whereArgs: [id],
    );
  }

  Future<bool> checkProduct(String name) async {
    final db = await getDatabase();

    List<Map<String, dynamic>> result = await db.query(
      "wishlist",
      where: "name=?",
      whereArgs: [name],
    );

    return result.isNotEmpty;
  }

  Future<void> deleteProductByName(String name) async {
    final db = await getDatabase();

    await db.delete(
      "wishlist",
      where: "name=?",
      whereArgs: [name],
    );
  }
}