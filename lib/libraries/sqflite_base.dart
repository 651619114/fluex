import './sqflite_init.dart';
import 'package:sqflite/sqflite.dart';
import 'package:meta/meta.dart';

abstract class SqfliteBase {
  bool isTableExits = false;
  createTableString();
  tableName();

  Future<Database> getDatabase() async {
    return await open();
  }

  @mustCallSuper
  create(String name, String createSql) async {
    isTableExits = await SqfliteManager.isTableExits(name);
    if (!isTableExits) {
      Database db = await SqfliteManager.getCurrentDatabase();
      return await db.execute(createSql);
    }
  }

  @mustCallSuper
  open() async {
    if (!isTableExits) {
      await create(tableName(), createTableString());
    }
    return await SqfliteManager.getCurrentDatabase();
  }
}
