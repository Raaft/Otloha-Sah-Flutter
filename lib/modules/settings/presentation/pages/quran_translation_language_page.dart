import 'package:flutter/material.dart';
import 'package:flutter_base/core/data/chash_helper.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/alert_dialog_full_screen.dart';
import 'package:flutter_base/modules/settings/data/models/init_data.dart';

import 'package:flutter_base/modules/settings/presentation/widgets/item_download.dart';
import 'package:flutter_base/modules/settings/presentation/widgets/search_bar_app.dart';
import 'package:get/get.dart';

class QuranTranslationLanguagePage extends StatefulWidget {
  const QuranTranslationLanguagePage({Key? key}) : super(key: key);

  static const routeName = '/settings/quranTranslationLanguage';

  @override
  _QuranTranslationLanguagePageState createState() =>
      _QuranTranslationLanguagePageState();
}

class _QuranTranslationLanguagePageState
    extends State<QuranTranslationLanguagePage> {
  int _selected = -1;

  @override
  Widget build(BuildContext context) {
    try {
      _selected = (CacheHelper.getData(key: 'QuranTranslationLanguageSelected')
              as int?) ??
          -1;
    } catch (e) {
      debugPrint(e.toString());
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [_topView(), _viewItems()],
        ),
      ),
    );
  }

  Widget _topView() {
    return SearchBarApp(
      backIcon: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: 'Quran Translation Language Center',
    );
  }

  Expanded _viewItems() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: 15,
          itemBuilder: (context, index) {
            return ItemDownload(
              name: 'Quran Translation Language ${index + 1}',
              description: 'surah',
              isDownloaded: true,
              isSelect: _selected == index,
              action: () {
                Get.dialog(
                  const AlertDialogFullScreen(),
                  barrierColor: AppColor.backdone,
                );
                CacheHelper.saveData(
                    key: 'QuranTranslationLanguageSelected', value: index);

                settings[4].subTitle = 'Quran Translation ${index + 1}';
                CacheHelper.saveData(
                    key: 'QuranTranslationLanguageSelectedName',
                    value: 'Quran Translation ${index + 1}');
                setState(() {
                  _selected = index;
                });
              },
            );
          },
        ),
      ),
    );
  }
}
