import 'package:flutter/material.dart';
import 'package:flutter_base/core/widgets/tool_bar_app.dart';
import 'package:flutter_base/modules/Quran/presentation/widget/item_download.dart';
import 'package:flutter_base/modules/Quran/presentation/widget/item_surah.dart';

class DownloadCenterPage extends StatefulWidget {
  const DownloadCenterPage({Key? key}) : super(key: key);
  static const routeName = '/quran/download-center';

  @override
  State<DownloadCenterPage> createState() => _DownloadCenterPageState();
}

class _DownloadCenterPageState extends State<DownloadCenterPage> {
  int _selected = -1;
  List<int> _downloaded = [];

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
      title: 'Downlod Center',
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
              name: 'name of recitation',
              surah: 'surah',
              isDownloaded: _downloaded.contains(index),
              isSelect: _selected == index,
              onLongPress: () {
                setState(() {
                  _selected = index;
                });
              },
              onDownload: () {
                setState(() {
                  _downloaded.add(index);
                });
              },
            );
          },
        ),
      ),
    );
  }
}
