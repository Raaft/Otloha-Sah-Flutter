import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/alert_dialog_full_screen.dart';
import 'package:flutter_base/core/widgets/tool_bar_app.dart';
import 'package:flutter_base/modules/quran/presentation/widget/item_download.dart';
import 'package:get/get.dart';

class RecitersPage extends StatefulWidget {
  const RecitersPage({Key? key}) : super(key: key);

  static const routeName = '/settings/reciters';
  @override
  _RecitersPageState createState() => _RecitersPageState();
}

class _RecitersPageState extends State<RecitersPage> {
  int _selected = -1;

  @override
  Widget build(BuildContext context) {
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
      title: 'Reciters Center',
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
              name: 'name of Reciter',
              surah: 'surah',
              isDownloaded: true,
              isSelect: _selected == index,
              action: () {
                Get.dialog(
                  const AlertDialogFullScreen(),
                  barrierColor: AppColor.backdone,
                );
                setState(() {
                  _selected = index;
                });

                Future.delayed(
                  const Duration(seconds: 2),
                  () {
                    Navigator.of(context).pop();
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
