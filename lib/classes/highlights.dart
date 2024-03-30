// import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class Highlight {
  static Future<void> createTable(sql.Database database) async {
    await database.execute("""CREATE TABLE highlight(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      verse TEXT,
      name TEXT,
      date TEXT
    );
""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('highlight.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTable(database);
    });
  }

  static Future<int> createItem(String verse, String name, String date) async {
    final db = await Highlight.db();
    final data = {'name': name, 'verse': verse, 'date': date};
    final id = await db.insert('highlight', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> gethighlight() async {
    final db = await Highlight.db();
    return await db.query('highlight', orderBy: 'id');
  }

  // static Future<List<Map<String, dynamic>>> getItem(int id) async {
  //   final db = await Highlight.db();
  //   return await db.query('highlight', where: 'id = ?', whereArgs: [id], limit: 1);
  // }

  // static Future<int> updateItem(int id, int counter) async {
  //   final db = await Highlight.db();
  //   final data = {
  //     'counter': counter,
  //   };

  //   final result =
  //       await db.update('highlight', data, where: 'id = ?', whereArgs: [id]);
  //   return result;
  // }

  static Future<void> deleteItem(int id) async {
    final db = await Highlight.db();
    try {
      await db.delete('highlight', where: 'id =?', whereArgs: [id]);
    } catch (err) {
      debugPrint('something went wrong when deleting an item: $err');
    }
  }
}
