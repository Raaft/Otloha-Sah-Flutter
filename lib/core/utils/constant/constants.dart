import 'package:flutter_base/modules/home/data/models/user/user_prfile.dart';

const String fontFamily1 = 'Cairo';
const String fontFamily2 = 'ElMessiri';

//const String baseUrl = 'http://192.168.1.11:8000';

const String baseUrl = 'http://otlohasah.noug.co';

String token = '';

var isEn = false;

const String clientId = '8qooczKuIdgU1ES0xfc0pEYEqPJRytXHxBcyY7TT';
///////
//const String clientSecret = '7VJuQ1DrwQzbMilum88be5tLCKx3QJOZ1Rjzp3dUTwNfo2yB8ir9qLWb5Y2xRGnfKcftZxkpVPflXaeP7KjteRFIZREp8WwOcr8Trvq5WVml84DKHoIHXjktBrzy3utk';
const String clientSecret =
    'O2JDrwEaQ0mQQLC2fjNyGSxTQ2qkjmfTfad4qKZn2Ut0P1kaHnT0x55pQd59c18t9FiKjok0chjvA6DvegslL2T1xL0ETqC5nRZ0WXNWWqF2uNTFnJHBOgaTHngIvHVi';

const String languagesSelectedName = 'LanguagesSelectedName';
const String languagesSelectedId = 'LanguagesSelectedId';
const String bookSelectedId = 'BookSelectedId';
const String bookSelectedName = 'BookSelectedName';
const String narrationSelectedId = 'NarrationSelectedId';
const String narrationSelectedName = 'NarrationSelectedName';
const String qtlSelectedId = 'QuranTranslationLanguageSelectedID';
const String qtlSelectedName = 'QuranTranslationLanguageSelectedName';
const String tafseerSelectedId = 'TafseerSelectedId';
const String tafseerSelectedName = 'TafseerSelectedName';
const String reciterSelectedId = 'ReciterSelectedId';
const String reciterSelectedName = 'ReciterSelectedName';
const String tajweedSelectedId = 'TajweedSelectedId';
const String tajweedSelectedName = 'TajweedSelectedName';
const String chapterSelectedID = 'ChapterID';
const String chapterSelectedName = 'ChapterName';
const String recitationSelectedId = 'RecitationSelectedId';

const String userProfileLogined = 'userProfileLogined';
const String favTeacher = 'favTeacherUserProfileLogined';

UserProfile? myProFile;
UserProfile? favTeacherProFile;
