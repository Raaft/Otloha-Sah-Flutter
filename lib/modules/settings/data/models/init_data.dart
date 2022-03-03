import 'package:flutter_base/core/data/chash_helper.dart';
import 'package:flutter_base/core/utils/constant/utils.dart';
import 'package:flutter_base/core/utils/res/icons_app.dart';
import 'package:flutter_base/modules/settings/presentation/pages/chapter_download_page.dart';
import 'package:flutter_base/modules/settings/data/models/language.dart';
import 'package:flutter_base/modules/settings/data/models/setting.dart';
import 'package:flutter_base/modules/settings/presentation/pages/books_page.dart';
import 'package:flutter_base/modules/settings/presentation/pages/languages_page.dart';
import 'package:flutter_base/modules/settings/presentation/pages/narration_page.dart';
import 'package:flutter_base/modules/settings/presentation/pages/quran_translation_language_page.dart';
import 'package:flutter_base/modules/settings/presentation/pages/reciters_page.dart';
import 'package:flutter_base/modules/settings/presentation/pages/tafseer_page.dart';
import 'package:flutter_base/modules/settings/presentation/pages/tajweed_page.dart';

final List<Settings> settings = [
  Settings(
    name: translate('Narration'),
    image: AppIcons.languageIcon,
    actionTo: NarrationPage.routeName,
    subTitle: CacheHelper.getData(key: 'NarrationsSelectedName'),
  ),
  Settings(
    name: translate('Reciters'),
    image: AppIcons.discussioncon,
    actionTo: RecitersPage.routeName,
    subTitle: CacheHelper.getData(key: 'ReciterSelectedName'),
  ),
  Settings(
    name: translate('Languages'),
    image: AppIcons.languageIcon,
    actionTo: LanguagesPage.routeName,
    subTitle: CacheHelper.getData(key: 'LanguagesSelectedName'),
  ),
  Settings(
    name: translate('QuranTranslationLanguage'),
    image: AppIcons.languageIcon,
    actionTo: QuranTranslationLanguagePage.routeName,
    subTitle: CacheHelper.getData(key: 'QuranTranslationLanguageSelectedName'),
  ),
  Settings(
    name: translate('Tafsir'),
    image: AppIcons.readingIcon,
    actionTo: TafseerPage.routeName,
    subTitle: CacheHelper.getData(key: 'TafseerSelectedName'),
  ),
  Settings(
    name: translate('Tajweed'),
    image: AppIcons.readingIcon,
    actionTo: TajweedPage.routeName,
    subTitle: CacheHelper.getData(key: 'TajweedSelectedName'),
  ),
];

final List<Settings> downLoadSettings = [
  Settings(
    name: translate('Books'),
    image: AppIcons.quran2Icon,
    actionTo: BooksPage.routeName,
    subTitle: CacheHelper.getData(key: 'BookSelectedName'),
  ),
  Settings(
    name: translate('Chapter'),
    image: AppIcons.downloadIcon,
    actionTo: ChapterDownloadPage.routeName,
  ),
];

List<Language> lang = [
  Language(langName: 'English', langCode: 'en'),
  Language(langName: 'العربية', langCode: 'ar'),
];

/*
 Settings(
    name: translate('Recitations'),
    image: AppIcons.discussioncon,
    actionTo: RecitationsPage.routeName,
    //  subTitle: CacheHelper.getData(key: 'ReciterSelectedName'),
  ),
*/