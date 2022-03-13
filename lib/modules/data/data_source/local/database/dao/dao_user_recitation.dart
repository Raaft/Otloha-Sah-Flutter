part of '../database/database.dart';

class UserRecitationDao {
  Future<List<UserRecitation>?> findAllUserRecitations() async {
    List<Map<String, dynamic>> maps =
        await AppDatabase._db!.query(RunQueries.userRecitationName);
    List<UserRecitation> items = [];
    if (maps.isNotEmpty) {
      for (var item in maps) {
        items.add(UserRecitation.fromMap(item));
      }

      return items;
    }
    return null;
  }

  Future<UserRecitation?> findUserRecitation(int id) async {
    List<Map<String, dynamic>> maps = await AppDatabase._db!.query(
        RunQueries.userRecitationName,
        where: 'uid = ?',
        whereArgs: [id]);
    List<UserRecitation> items = [];
    if (maps.isNotEmpty) {
      for (var item in maps) {
        items.add(UserRecitation.fromMap(item));
      }
      return items.first;
    }
    return null;
  }

  Future<UserRecitation?> insert(UserRecitation userRecitation) async {
    userRecitation.id = await AppDatabase._db!
        .insert(RunQueries.userRecitationName, userRecitation.toMap());
    return userRecitation;
  }

  Future<int> delete(int id) async {
    return await AppDatabase._db!.delete(RunQueries.userRecitationName,
        where: 'uid = ?', whereArgs: [id]);
  }

  Future<int> update(UserRecitation userRecitation) async {
    return await AppDatabase._db!.update(
        RunQueries.userRecitationName, userRecitation.toMap(),
        where: 'uid = ?', whereArgs: [userRecitation.id]);
  }
}
