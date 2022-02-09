import 'package:flutter_base/core/utils/constant/utils.dart';
import 'package:flutter_base/core/utils/res/icons_app.dart';
import 'package:flutter_base/modules/quran/presentation/page/download_center_page.dart';
import 'package:flutter_base/modules/settings/data/models/setting.dart';
import 'package:flutter_base/modules/settings/presentation/pages/books_page.dart';
import 'package:flutter_base/modules/settings/presentation/pages/languages_page.dart';
import 'package:flutter_base/modules/settings/presentation/pages/narration_page.dart';
import 'package:flutter_base/modules/settings/presentation/pages/quran_translation_language_page.dart';
import 'package:flutter_base/modules/settings/presentation/pages/reciters_page.dart';
import 'package:flutter_base/modules/settings/presentation/pages/tafseer_page.dart';

final List<Settings> settings = [
  Settings(
      name: translate('Narration'),
      image: AppIcons.languageIcon,
      actionTo: NarrationPage.routeName),
  Settings(
      name: translate('Reciters'),
      image: AppIcons.languageIcon,
      actionTo: RecitersPage.routeName),
  Settings(
      name: translate('Languages'),
      image: AppIcons.languageIcon,
      actionTo: LanguagesPage.routeName),
  Settings(
      name: translate('QuranTranslationLanguage'),
      image: AppIcons.languageIcon,
      actionTo: QuranTranslationLanguagePage.routeName),
  Settings(
      name: translate('Tafsir'),
      image: AppIcons.languageIcon,
      actionTo: TafseerPage.routeName),
  Settings(
      name: translate('Books'),
      image: AppIcons.languageIcon,
      actionTo: BooksPage.routeName),
  Settings(
      name: translate('ChapterDownloadCenter'),
      image: AppIcons.downloadIcon,
      actionTo: DownloadCenterPage.routeName),
];
