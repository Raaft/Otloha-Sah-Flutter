import 'database/database.dart';
import '../../models/database_model/verse_note.dart';

class DatabaseRepository {
  static final AppDatabase _database = AppDatabase();
  static PageMarkedDao? pageMarkedDao;
  static VerseNoteDao? verseNoteDao;
  static VerseLikedDao? verseLikedDao;

  Future<DatabaseRepository> get initDb async {
    await _database.database;
    pageMarkedDao = _database.pageMarkedDao;
    verseNoteDao = _database.verseNoteDao;
    verseLikedDao = _database.verseLikedDao;

    return this;
  }

  // Verse Liked
  findAllVerseLikeds() async => await verseLikedDao!.findAll();

  findVerseLikedById(int id) async => await verseLikedDao!.findById(id);

  insertVerseLiked(verseLiked) async => await verseLikedDao!.insert(verseLiked);

  updateVerseLiked(verseLiked) async => await verseLikedDao!.update(verseLiked);

  deleteVerseLiked(int id) async => await verseLikedDao!.delete(id);

  // Verse Note
  findAllVerseNotes() async => await verseNoteDao!.findAll();

  findVerseNoteById(int id) async => await verseNoteDao!.findById(id);

  Future<VerseNote?>? insertVerseNote(VerseNote verseNote) async =>
      await verseNoteDao!.insert(verseNote);

  updateVerseNote(VerseNote verseNote) async =>
      await verseNoteDao!.update(verseNote);

  deleteVerseNote(int id) async => await verseNoteDao!.delete(id);

  // Page Marked
  findAllPageMarkeds() async => await pageMarkedDao!.findAll();

  findPageMarkedById(int id) async => await pageMarkedDao!.findById(id);

  insertPageMarked(pageMarked) async => await pageMarkedDao!.insert(pageMarked);

  updatePageMarked(pageMarked) async => await pageMarkedDao!.update(pageMarked);

  deletePageMarked(int id) async => await pageMarkedDao!.delete(id);

////
}
