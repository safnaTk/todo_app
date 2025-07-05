import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class AssetController with ChangeNotifier {
  static late Database database;
  static List<Map> assetList = [];

  //  Open the database
  static Future<void> openDb() async {
    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
    }

    database = await openDatabase(
      "asset_manager.db", // DB name
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE Assets (
            id INTEGER PRIMARY KEY,
            type TEXT,
            name TEXT,
            description TEXT,
            serialNumber TEXT,
            isAvailable INTEGER
          )
        ''');
      },
    );
  }

  //  Add asset
  static Future<void> addAsset({
    required String type,
    required String name,
    required String description,
    required String serialNumber,
    required bool isAvailable,
  }) async {
    await database.rawInsert(
      'INSERT INTO Assets(type, name, description, serialNumber, isAvailable) VALUES (?, ?, ?, ?, ?)',
      [type, name, description, serialNumber, isAvailable ? 1 : 0],
    );
    await getAllAssets();
  }

  // Get all assets
  static Future<void> getAllAssets() async {
    assetList = await database.rawQuery('SELECT * FROM Assets');
  }

  //  Delete asset
  static Future<void> deleteAsset(int id) async {
    await database.rawDelete('DELETE FROM Assets WHERE id = ?', [id]);
    await getAllAssets();
  }

  //  Update asset
  static Future<void> updateAsset({
    required int id,
    required String type,
    required String name,
    required String description,
    required String serialNumber,
    required bool isAvailable,
  }) async {
    await database.rawUpdate(
      'UPDATE Assets SET type = ?, name = ?, description = ?, serialNumber = ?, isAvailable = ? WHERE id = ?',
      [type, name, description, serialNumber, isAvailable ? 1 : 0, id],
    );
    await getAllAssets();
  }
}
