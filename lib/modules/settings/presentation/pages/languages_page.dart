import 'package:flutter/material.dart';
import 'package:flutter_base/core/data/chash_helper.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/alert_dialog_full_screen.dart';
import 'package:flutter_base/core/widgets/tool_bar_app.dart';
import 'package:flutter_base/modules/quran/presentation/widget/item_download.dart';
import 'package:get/get.dart';

class LanguagesPage extends StatefulWidget {
  const LanguagesPage({Key? key}) : super(key: key);

  static const routeName = '/settings/languages';
  @override
  _LanguagesPageState createState() => _LanguagesPageState();
}

class _LanguagesPageState extends State<LanguagesPage> {
  int _selected = -1;

  @override
  Widget build(BuildContext context) {
    try {
      _selected = (CacheHelper.getData(key: 'LanguagesSelected') as int?) ?? -1;
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
    return ToolBarApp(
      backIcon: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      actionIcon: IconButton(
        icon: const Icon(Icons.search),
        onPressed: () {},
      ),
      title: 'Languages Center',
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
              name: 'Languages ${index + 1}',
              surah: 'surah',
              isDownloaded: true,
              isSelect: _selected == index,
              action: () {
                Get.dialog(
                  const AlertDialogFullScreen(),
                  barrierColor: AppColor.backdone,
                );
                CacheHelper.saveData(key: 'LanguagesSelected', value: index);
                CacheHelper.saveData(
                    key: 'LanguagesSelectedName',
                    value: 'Languages ${index + 1}');
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
