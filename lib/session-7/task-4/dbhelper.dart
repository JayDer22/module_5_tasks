import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static final _databaseName = "task4.db";
  static final table = 'user_rewards';
  static final columnPoints = 'points';

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
          'CREATE TABLE $table (id INTEGER PRIMARY KEY, $columnPoints INTEGER)',
        );
        await db.insert(table, {'id': 1, columnPoints: 100});
      },
    );
  }

  // Task 4: Fix race condition using transactions or proper sequencing
  Future<void> updatePointsSecurely(int additionalPoints) async {
    final db = await instance.database;

    // Using a transaction ensures that the read and write are atomic
    await db.transaction((txn) async {
      // 1. Get current points
      final List<Map<String, dynamic>> result = await txn.query(
        table,
        where: 'id = ?',
        whereArgs: [1],
      );
      int currentPoints = result.isNotEmpty ? result.first[columnPoints] as int : 0;

      // 2. Calculate new points
      int newPoints = currentPoints + additionalPoints;

      // 3. Update the database
      await txn.update(
        table,
        {columnPoints: newPoints},
        where: 'id = ?',
        whereArgs: [1],
      );
    });
  }

  Future<int> getPoints() async {
    final db = await instance.database;
    final result = await db.query(table, where: 'id = ?', whereArgs: [1]);
    return result.isNotEmpty ? result.first[columnPoints] as int : 0;
  }
}
