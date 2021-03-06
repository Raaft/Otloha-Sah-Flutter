
import '../../../models/database_model/page_marked.dart';
import '../../../models/database_model/verse_like.dart';
import '../../../models/database_model/verse_note.dart';
import 'package:sqflite/sqflite.dart';

import '../../../models/database_model/user.dart';
import '../../../models/database_model/user_recitation.dart';

part 'run_query.dart';
part '../dao/dao_user.dart';
part '../dao/dao_verse_note.dart';
part '../dao/dao_verse_liked.dart';
part '../dao/dao_page_marked.dart';
part '../dao/dao_user_recitation.dart';

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
  UserRecitationDao get userRecitationDao => UserRecitationDao();

  String join(String databasesPath, String databasesName) {
    return '$databasesPath/$databasesName';
  }
}
