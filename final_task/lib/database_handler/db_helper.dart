import 'package:final_task/model/user_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class DbHelper{
  static late Database _db;

  static const String DB_Name = 'final_task.db';

  static const String Table_User = 'user';

  static const int Version = 1;

  static const String C_UserLogin = 'login';
  static const String C_UserName = 'name';
  static const String C_UserEmail = 'email';
  static const String C_UserPassword = 'password';

  Future<Database> get db async{
    if(_db != null){
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async{
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();//возвращает путь к директории приложения, где могут храниться файлы, созданные вашим приложением
    String path = join (documentDirectory.path, DB_Name);
    var db = await openDatabase(path, version: Version, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int intVersion) async{
    await db.execute("CREATE TABLE $Table_User("
        "$C_UserLogin TEXT"
        "$C_UserName TEXT"
        "$C_UserEmail TEXT"
        "$C_UserPassword TEXT"
        "PRIMARY KEY ($C_UserLogin)"
    ")");
  }
  Future<int> saveData(UserModel user) async {
    var dbClient = await db;
    var res = await dbClient.insert(Table_User, user.toMap());
    return res;
  }

  Future<UserModel?> getLoginUser(String login, String password) async {
    var dbClient = await db;
    var res = await dbClient.rawQuery("SELECT * FROM $Table_User WHERE "
        "$C_UserLogin = '$login' AND "
        "$C_UserPassword = '$password'");

    if (res.length > 0) {
      return UserModel.fromMap(res.first);
    }

    return null;
  }

  Future<int> updateUser(UserModel user) async {
    var dbClient = await db;
    var res = await dbClient.update(Table_User, user.toMap(),
        where: '$C_UserLogin = ?', whereArgs: [user.login]);
    return res;
  }

  Future<int> deleteUser(String login) async {
    var dbClient = await db;
    var res = await dbClient
        .delete(Table_User, where: '$C_UserLogin = ?', whereArgs: [login]);
    return res;
  }
}

