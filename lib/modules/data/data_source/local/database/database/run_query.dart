part of 'database.dart';

class RunQueries {
  static const verseName = 'Verse';
  static const verseNoteName = 'VerseNote';
  static const verseLikedName = 'VerseLiked';
  static const pageName = 'Page';
  static const pageMarkedName = 'PageMarked';
  static const userName = 'user';
  static const userRecitationName = 'UserRecitation';

  runQueries(Database db) async {
    var list = queries.split(';');

    for (var item in list) {
      db.execute(item);
    }
  }

  final queries = '''
CREATE TABLE IF NOT EXISTS "VerseNote" (
	"id"	INTEGER NOT NULL,
	"idFromVerse"	INTEGER,
	"idToVerse"	INTEGER,
	"idPage"	INTEGER,
	"pageNumber"	INTEGER,
	"textFristVerse"	TEXT,
	"noteText"	TEXT,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "PageMarked" (
	"id"	INTEGER NOT NULL,
	"idPage"	INTEGER NOT NULL,
	"idBook"	INTEGER,
	"pageNumber"	INTEGER,
	"textVerse"	TEXT,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "VerseLiked" (
	"id"	INTEGER NOT NULL,
	"idFromVerse"	INTEGER NOT NULL,
	"idToVerse"	INTEGER,
	"idPage"	INTEGER,
	"pageNumber"	INTEGER,
	"textFristVerse"	TEXT,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE "UserRecitation" (
	"id"	INTEGER NOT NULL,
	"narration_id"	INTEGER,
	"record"	INTEGER,
	"versesID"	TEXT,
	"name"	TEXT,
	"uploaded"	INTEGER DEFAULT 0,
	PRIMARY KEY("id" AUTOINCREMENT)
);
''';
}
