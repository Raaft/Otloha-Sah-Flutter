import 'package:flutter/material.dart';
import 'package:flutter_base/core/widgets/tool_bar_app.dart';
import 'package:flutter_base/modules/quran/presentation/widget/item_download.dart';

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
              name: 'name of Languages',
              surah: 'surah',
              isDownloaded: true,
              isSelect: _selected == index,
              onLongPress: () {
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
