import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqfliteManager {
  static Database _database;
  static const _VERSION = 1;
  static const _NAME = "word.db";

  static init() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, _NAME);
    _database = await openDatabase(path,
        version: _VERSION, onCreate: (Database db, int version) async {});
  }

  static isTableExits(String tableName) async {
    await getCurrentDatabase();
    var res = await _database.rawQuery(
        "select * from Sqlite_master where type = 'table' and name = '$tableName'");
    return res != null && res.length > 0;
  }

  static Future<Database> getCurrentDatabase() async {
    if (_database == null) {
      await init();
    }
    return _database;
  }

  static close() {
    _database?.close();
    _database = null;
  }
}
