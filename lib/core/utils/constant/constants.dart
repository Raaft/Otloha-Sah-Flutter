import 'package:flutter_base/modules/home/data/models/user/user_prfile.dart';

const String fontFamily1 = 'Cairo';
const String fontFamily2 = 'ElMessiri';

// const String baseUrl = 'http://192.168.1.11:8000';

const String baseUrl = 'http://otlohasah.noug.co';

String token = '';

var isEn = false;

const String clientId = '5zwW1EStI8d0G18Ff6sSeZtCoF3VW3rZL7hHLdwz';
///////
//const String clientSecret = '7VJuQ1DrwQzbMilum88be5tLCKx3QJOZ1Rjzp3dUTwNfo2yB8ir9qLWb5Y2xRGnfKcftZxkpVPflXaeP7KjteRFIZREp8WwOcr8Trvq5WVml84DKHoIHXjktBrzy3utk';
const String clientSecret =
    'b3DgiOv9XvIZ17yMakUpqpFFv79N3M2sbV7iN9HCLoTeKhhxF6Dcd2s2ASKovRbdoJVCEed53eREAdgt0lvBXS74Wq6jFGX5e0XDeyywbPAqCKo4MYQKqnJZ3UHxipkl';

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
