part of '../database/database.dart';

class VerseLikedDao {
  Future<List<VerseLiked>?> findAll() async {
    List<Map<String, dynamic>> maps =
        await AppDatabase._db!.query(RunQueries.verseLikedName);
    List<VerseLiked> items = [];
    if (maps.isNotEmpty) {
      for (var item in maps) {
        items.add(VerseLiked.fromMap(item));
      }

      return items;
    }
    return null;
  }

  Future<VerseLiked?> findById(int id) async {
    List<Map<String, dynamic>> maps = await AppDatabase._db!
        .query(RunQueries.verseLikedName, where: 'id = ?', whereArgs: [id]);
    List<VerseLiked> items = [];
    if (maps.isNotEmpty) {
      for (var item in maps) {
        items.add(VerseLiked.fromMap(item));
      }
      return items.first;
    }
    return null;
  }

  Future<VerseLiked?> insert(VerseLiked verseLike) async {
    verseLike.id = await AppDatabase._db!
        .insert(RunQueries.verseLikedName, verseLike.toMap());
    return verseLike;
  }

  Future<int> delete(int id) async {
    return await AppDatabase._db!
        .delete(RunQueries.verseLikedName, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(VerseLiked verseLike) async {
    return await AppDatabase._db!.update(
        RunQueries.verseLikedName, verseLike.toMap(),
        where: 'uid = ?', whereArgs: [verseLike.id]);
  }
}
