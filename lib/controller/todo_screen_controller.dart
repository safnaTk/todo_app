import 'package:flutter/foundation.dart';

import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class TodoScreenController {
  static late Database database;
  static List<Map> taskList = [];

  //sqflite codes----

  static Future<void> openDb() async {
    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
    }
    // open the database

    database = await openDatabase(
      "todo.db", // path-db name
      version: 1,
      onCreate: (Database db, int version) async {
        // when creating db,create table
        // db database object
        await db.execute(
          'CREATE TABLE Todo (id INTEGER PRIMARY KEY, title TEXT, des TEXT)',
        );
      },
    );
  }

  // insert a task to db
  static Future<void> addTask({
    required String title,
    required String des,
  }) async {
    await database.rawInsert('INSERT INTO Todo(title, des) VALUES(?,?)', [
      title,
      des,
    ]);
    await getAllTasks();
  }

  // get data from db
  static Future<void> getAllTasks() async {
    taskList = await database.rawQuery('SELECT * FROM Todo');
  }

  // delete data
  static Future<void> deleteTask(var taskId) async {
    await database.rawDelete('DELETE FROM Todo WHERE id = ?', [taskId]);
    await getAllTasks();
  }

  static Future<void> updateTask({
    required String title,
    required String des,
    required var taskId,
  }) async {
    await database.rawUpdate(
      'UPDATE Todo SET title = ?, des = ? WHERE id = ?',
      [title, des, taskId],
    );
    await getAllTasks();
  }

  static Future<void> updateTaskStatus(int id, String status) async {
    await database.rawUpdate('UPDATE Todo SET status = ? WHERE id = ?', [
      status,
      id,
    ]);
    await getAllTasks();
  }
}
