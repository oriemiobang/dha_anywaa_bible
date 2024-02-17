// import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTable(sql.Database database) async {
    await database.execute("""CREATE TABLE items(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      counter INTEGER 
    );
""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('mydb.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTable(database);
    });
  }

  static Future<int> createItem(int counter) async {
    final db = await SQLHelper.db();
    final data = {'counter': counter};
    final id = await db.insert('items', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return await db.query('items', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();
    return await db.query('items', where: 'id = ?', whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(int id, int counter) async {
    final db = await SQLHelper.db();
    final data = {
      'counter': counter,
    };

    final result =
        await db.update('items', data, where: 'id = ?', whereArgs: [id]);
    return result;
  }

  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete('items', where: 'id =?', whereArgs: [id]);
    } catch (err) {
      debugPrint('something went wrong when deleting an item: $err');
    }
  }
}
