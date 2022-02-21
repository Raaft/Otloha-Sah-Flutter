import 'package:flutter_base/modules/data/model/page_marked.dart';
import 'package:flutter_base/modules/data/model/user.dart';
import 'package:flutter_base/modules/data/model/verse_like.dart';
import 'package:flutter_base/modules/data/model/verse_note.dart';
import 'package:sqflite/sqflite.dart';

part 'run_query.dart';
part '../dao/dao_user.dart';
part '../dao/dao_verse_note.dart';
part '../dao/dao_verse_liked.dart';
part '../dao/dao_page_marked.dart';

class AppDatabase {
  static Database? _db;
  String? _path;

  Future get database async {
    if (_db == null) {
      await open(await path);
    }

    return _db!;
  }

  Future<String> get path async {
    var databasesPath = await getDatabasesPath();
    _path = join(databasesPath, 'quran.db');
    return _path ?? '';
  }

  Future<Database> open(String path) async {
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        /// run create tables
        RunQueries().runQueries(db);
      },
    );

    return _db!;
  }

  Future close() async => _db!.close();

  VerseNoteDao get verseNoteDao => VerseNoteDao();
  VerseLikedDao get verseLikedDao => VerseLikedDao();
  PageMarkedDao get pageMarkedDao => PageMarkedDao();

  String join(String databasesPath, String databasesName) {
    return '$databasesPath/$databasesName';
  }
}
