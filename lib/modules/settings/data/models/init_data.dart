import 'package:flutter_base/core/utils/res/icons_app.dart';
import 'package:flutter_base/modules/quran/presentation/page/download_center_page.dart';
import 'package:flutter_base/modules/settings/data/models/setting.dart';

final List<Settings> settings = [
  Settings(name: 'Narration', image: AppIcons.languageIcon),
  Settings(name: 'Reciters', image: AppIcons.languageIcon),
  Settings(name: 'Languages', image: AppIcons.languageIcon),
  Settings(name: 'Quran Translation Language', image: AppIcons.languageIcon),
  Settings(name: 'Tafseer', image: AppIcons.languageIcon),
  Settings(name: 'Books', image: AppIcons.languageIcon),
  Settings(name: 'Books', image: AppIcons.languageIcon),
  Settings(
      name: 'Chapter Download Center ',
      image: AppIcons.downloadIcon,
      actionTo: DownloadCenterPage.routeName),
];
