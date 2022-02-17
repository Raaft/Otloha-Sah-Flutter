part of '../database/database.dart';

class PageMarkedDao {
  Future<List<PageMarked>?> findAll() async {
    List<Map<String, dynamic>> maps =
        await AppDatabase._db!.query(RunQueries.pageMarkedName);
    List<PageMarked> items = [];
    if (maps.isNotEmpty) {
      for (var item in maps) {
        items.add(PageMarked.fromMap(item));
      }

      return items;
    }
    return null;
  }

  Future<PageMarked?> findById(int id) async {
    List<Map<String, dynamic>> maps = await AppDatabase._db!
        .query(RunQueries.pageMarkedName, where: 'id = ?', whereArgs: [id]);
    List<PageMarked> items = [];
    if (maps.isNotEmpty) {
      for (var item in maps) {
        items.add(PageMarked.fromMap(item));
      }
      return items.first;
    }
    return null;
  }

  Future<PageMarked?> insert(PageMarked pageMarked) async {
    pageMarked.id = await AppDatabase._db!
        .insert(RunQueries.pageMarkedName, pageMarked.toMap());
    return pageMarked;
  }

  Future<int> delete(int id) async {
    return await AppDatabase._db!
        .delete(RunQueries.pageMarkedName, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(PageMarked pageMarked) async {
    return await AppDatabase._db!.update(
        RunQueries.pageMarkedName, pageMarked.toMap(),
        where: 'uid = ?', whereArgs: [pageMarked.id]);
  }
}
