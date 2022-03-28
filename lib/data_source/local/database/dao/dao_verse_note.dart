part of '../database/database.dart';

class VerseNoteDao {
  Future<List<VerseNote>?> findAll() async {
    List<Map<String, dynamic>> maps =
        await AppDatabase._db!.query(RunQueries.verseNoteName);
    List<VerseNote> items = [];
    if (maps.isNotEmpty) {
      for (var item in maps) {
        items.add(VerseNote.fromMap(item));
      }

      return items;
    }
    return null;
  }

  Future<VerseNote?> findById(int id) async {
    List<Map<String, dynamic>> maps = await AppDatabase._db!
        .query(RunQueries.verseNoteName, where: 'id = ?', whereArgs: [id]);
    List<VerseNote> items = [];
    if (maps.isNotEmpty) {
      for (var item in maps) {
        items.add(VerseNote.fromMap(item));
      }
      return items.first;
    }
    return null;
  }

  Future<VerseNote?> insert(VerseNote verseNote) async {
    verseNote.id = await AppDatabase._db!
        .insert(RunQueries.verseNoteName, verseNote.toMap());
    return verseNote;
  }

  Future<int> delete(int id) async {
    return await AppDatabase._db!
        .delete(RunQueries.verseNoteName, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(VerseNote verseNote) async {
    return await AppDatabase._db!.update(
        RunQueries.verseNoteName, verseNote.toMap(),
        where: 'uid = ?', whereArgs: [verseNote.id]);
  }
}
