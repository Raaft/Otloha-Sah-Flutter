import 'package:flutter/material.dart';
import 'package:flutter_base/core/data/chash_helper.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/alert_dialog_full_screen.dart';
import 'package:flutter_base/modules/quran/presentation/widget/item_download.dart';
import 'package:flutter_base/modules/settings/presentation/widgets/search_bar_app.dart';
import 'package:get/get.dart';

class BooksPage extends StatefulWidget {
  const BooksPage({Key? key}) : super(key: key);

  static const routeName = '/settings/books';

  @override
  State<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  int _selected = -1;

  @override
  Widget build(BuildContext context) {
    try {
      _selected = (CacheHelper.getData(key: 'BookSelected') as int?) ?? -1;
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
      title: 'Books Center',
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
              name: 'Books Name ${index + 1}',
              surah: 'surah',
              isDownloaded: true,
              isSelect: _selected == index,
              action: () {
                Get.dialog(
                  const AlertDialogFullScreen(),
                  barrierColor: AppColor.backdone,
                );
                CacheHelper.saveData(key: 'BookSelected', value: index);
                CacheHelper.saveData(
                    key: 'BookSelectedName', value: 'Books Name ${index + 1}');
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
