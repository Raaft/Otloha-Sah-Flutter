part of '../database/database.dart';

class UserDao {
  Future<List<User>?> findAllUsers() async {
    List<Map<String, dynamic>> maps =
        await AppDatabase._db!.query(AppDatabase.userName);
    List<User> items = [];
    if (maps.isNotEmpty) {
      for (var item in maps) {
        items.add(User.fromMap(item));
      }

      return items;
    }
    return null;
  }

  Future<User?> findUser(int id) async {
    List<Map<String, dynamic>> maps = await AppDatabase._db!
        .query(AppDatabase.userName, where: 'uid = ?', whereArgs: [id]);
    List<User> items = [];
    if (maps.isNotEmpty) {
      for (var item in maps) {
        items.add(User.fromMap(item));
      }
      return items.first;
    }
    return null;
  }

  Future<User?> insert(User user) async {
    user.uid =
        await AppDatabase._db!.insert(AppDatabase.userName, user.toMap());
    return user;
  }

  Future<int> delete(int id) async {
    return await AppDatabase._db!
        .delete(AppDatabase.userName, where: 'uid = ?', whereArgs: [id]);
  }

  Future<int> update(User user) async {
    return await AppDatabase._db!.update(AppDatabase.userName, user.toMap(),
        where: 'uid = ?', whereArgs: [user.uid]);
  }
}
