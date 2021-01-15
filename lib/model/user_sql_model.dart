import 'user.dart';
import '../libraries/sqflite_base.dart';
import 'package:sqflite/sqlite_api.dart';

class UserSqlModel extends SqfliteBase {
  final String name = 'user';
  final String columnId = 'id';
  final String columnName = 'username';
  UserSqlModel();
  @override
  tableName() {
    return name;
  }

  @override
  createTableString() {
    return '''
        create table $name (
        $columnId integer primary key not null,
        $columnName TEXT not null
        )
      ''';
  }

  Future _getUserModel(Database db, int id) async {
    List<Map<String, dynamic>> maps =
        await db.rawQuery("select * from $name where $columnId=$id");
    return maps;
  }

  Future insert(User model) async {
    Database db = await getDatabase();
    var user = await _getUserModel(db, model.id);
    if (user != null) {
      await db.delete(name, where: "$columnId=?", whereArgs: [model.id]);
    }
    return await db.rawInsert(
        "insert into $name ($columnId,$columnName) values (?,?)",
        [model.id, model.username]);
  }

  ///更新数据库
  Future<void> update(User model) async {
    Database database = await getDatabase();
    await database.rawUpdate(
        "update $name set $columnName = ? where $columnId= ?",
        [model.username, model.id]);
  }

  Future<User> getInfo(int id) async {
    Database db = await getDatabase();
    List<Map<String, dynamic>> maps = await _getUserModel(db, id);
    if (maps.length > 0) {
      return User.fromJsonMap(maps[0]);
    }
    return null;
  }
}
