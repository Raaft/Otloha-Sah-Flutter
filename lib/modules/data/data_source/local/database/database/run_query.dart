part of 'database.dart';

class RunQueries {
  static const verseName = 'Verse';
  static const verseNoteName = 'VerseNote';
  static const verseLikedName = 'VerseLiked';
  static const pageName = 'Page';
  static const pageMarkedName = 'PageMarked';
  static const userName = 'useruser';

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
);''';

//// old
  final queries2 = '''
CREATE TABLE IF NOT EXISTS "$verseName" (
	"id"	INTEGER NOT NULL AUTOINCREMENT,
	"text"	TEXT,
	"uthmanicText"	TEXT,
	"lineStart"	INTEGER,
	"lineEnd"	INTEGER,
	"image"	TEXT,
	"narrationId"	INTEGER,
	"chapterId"	INTEGER,
	"bookId"	INTEGER,
	"partId"	INTEGER,
	"pageId"	INTEGER,
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "$verseNoteName" (
	"id"	INTEGER NOT NULL AUTOINCREMENT,
	"idVerse"	INTEGER,
	"noteText"	TEXT,
	"textVerse"	TEXT,
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "$verseLikedName" (
	"id"	INTEGER NOT NULL,
	"idVerse"	INTEGER NOT NULL,
	"textVerse"	INTEGER,
	"isLiked"	INTEGER,
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "$pageName" (
	"id"	INTEGER NOT NULL AUTOINCREMENT,
	"pageNumber"	INTEGER NOT NULL,
	"chapterId"	INTEGER,
	"bookId"	INTEGER,
	"narrationId"	INTEGER,
	"partId"	INTEGER,
	"image"	TEXT,
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "$pageMarkedName" (
	"id"	INTEGER NOT NULL AUTOINCREMENT,
	"idPage"	INTEGER NOT NULL,
	"pageNumber"	INTEGER,
	"text"	TEXT,
	PRIMARY KEY("id")
);
'''; //// old
}
