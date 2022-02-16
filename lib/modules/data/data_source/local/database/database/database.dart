import 'package:flutter_base/modules/data/model/user.dart';
import 'package:sqflite/sqflite.dart';

part '../dao/dao_user.dart';

class AppDatabase {
  static Database? _db;
  String? _path;

  static String chiarName = 'chiars';
  static String chiarDeletedName = 'chiarsDeleted';
  static String userName = 'useruser';
  static String historyName = 'history';

  Future get database async {
    if (_db == null) {
      open(await path);
    }

    ///return _db!;
  }

  Future<String> get path async {
    var databasesPath = await getDatabasesPath();
    _path = join(databasesPath, 'chairs.db');
    return _path ?? '';
  }

  Future<Database> open(String path) async {
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        /// run create tables
      },
    );

    return _db!;
  }

  Future close() async => _db!.close();

  UserDao get userDao => UserDao();

  String join(String databasesPath, String databasesName) {
    return '$databasesPath/$databasesName';
  }
}
