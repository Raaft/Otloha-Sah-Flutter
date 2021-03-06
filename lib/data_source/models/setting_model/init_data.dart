import 'package:easy_localization/easy_localization.dart';

import '../../cache_helper.dart';
import '../../../core/utils/constant/constants.dart';
import '../../../core/utils/constant/utils.dart';
import '../../../core/utils/res/icons_app.dart';
import 'language.dart';
import '../../../modules/settings/presentation/pages/settings/chapter_download_page.dart';
import 'setting.dart';
import '../../../modules/settings/presentation/pages/settings/books_page.dart';
import '../../../modules/settings/presentation/pages/settings/languages_page.dart';
import '../../../modules/settings/presentation/pages/settings/narration_page.dart';
import '../../../modules/settings/presentation/pages/settings/quran_translation_language_page.dart';
import '../../../modules/settings/presentation/pages/settings/reciters_page.dart';
import '../../../modules/settings/presentation/pages/settings/tafseer_page.dart';
import '../../../modules/settings/presentation/pages/settings/tajweed_page.dart';

final List<Settings> settings = [
  Settings(
    name: translate('Narration'),
    image: AppIcons.languageIcon,
    actionTo: NarrationPage.routeName,
    subTitle: CacheHelper.getData(key: narrationSelectedName),

  ),
  Settings(
    name: translate('Reciters'),
    image: AppIcons.discussioncon,
    actionTo: RecitersPage.routeName,
    subTitle: CacheHelper.getData(key: reciterSelectedName),
  ),
  Settings(
    name: translate('Languages'),
    image: AppIcons.languageIcon,
    actionTo: LanguagesPage.routeName,
    subTitle: CacheHelper.getData(key: languagesSelectedName)??tr('Arabic'),
  ),
  Settings(
    name: translate('QuranTranslationLanguage'),
    image: AppIcons.languageIcon,
    actionTo: QuranTranslationLanguagePage.routeName,
    subTitle: CacheHelper.getData(key: qtlSelectedName),
  ),
  Settings(
    name: translate('Tafsir'),
    image: AppIcons.readingIcon,
    actionTo: TafseerPage.routeName,
    subTitle: CacheHelper.getData(key: tafseerSelectedName),
  ),
  Settings(
    name: translate('Tajweed'),
    image: AppIcons.readingIcon,
    actionTo: TajweedPage.routeName,
    subTitle: CacheHelper.getData(key: tajweedSelectedName),
  ),
];

final List<Settings> downLoadSettings = [
  Settings(
    name: translate('Books'),
    image: AppIcons.quran2Icon,
    actionTo: BooksPage.routeName,
    subTitle: CacheHelper.getData(key: bookSelectedName),
  ),
  Settings(
    name: translate('Chapter'),
    image: AppIcons.downloadIcon,
    actionTo: ChapterDownloadPage.routeName,
  ),
];

List<Language> lang = [
  Language(langName: 'English', langCode: 'en'),
  Language(langName: '??????????????', langCode: 'ar'),
];

/*
 Settings(
    name: translate('Recitations'),
    image: AppIcons.discussioncon,
    actionTo: RecitationsPage.routeName,
    //  subTitle: CacheHelper.getData(key: 'ReciterSelectedName'),
  ),
*/