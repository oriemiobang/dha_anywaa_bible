// import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class ColorHighlight {
  static Future<void> createTable(sql.Database database) async {
    await database.execute("""CREATE TABLE colorhighlight(
      id TEXT PRIMARY KEY,
      color INTEGER
    );
""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('colorhighlight.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTable(database);
    });
  }

  static Future<int> createItem(String myid, int color) async {
    final db = await ColorHighlight.db();
    final data = {'id': myid, 'color': color};
    final id = await db.insert('colorhighlight', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> gethighlight() async {
    final db = await ColorHighlight.db();
    return await db.query('colorhighlight');
  }

  // static Future<List<Map<String, dynamic>>> getItem(int id) async {
  //   final db = await Highlight.db();
  //   return await db.query('colorhighlight', where: 'id = ?', whereArgs: [id], limit: 1);
  // }

  // static Future<int> updateItem(int id, int counter) async {
  //   final db = await Highlight.db();
  //   final data = {
  //     'counter': counter,
  //   };

  //   final result =
  //       await db.update('colorhighlight', data, where: 'id = ?', whereArgs: [id]);
  //   return result;
  // }

  static Future<void> deleteItem(String id) async {
    final db = await ColorHighlight.db();
    try {
      await db.delete('colorhighlight', where: 'id =?', whereArgs: [id]);
    } catch (err) {
      debugPrint('something went wrong when deleting an item: $err');
    }
  }
}
