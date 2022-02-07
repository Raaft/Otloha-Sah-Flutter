import 'package:flutter/material.dart';
import 'package:flutter_base/core/widgets/tool_bar_app.dart';
import 'package:flutter_base/modules/Quran/presentation/widget/item_surah.dart';

class IndexSurahPage extends StatefulWidget {
  const IndexSurahPage({Key? key}) : super(key: key);
  static const routeName = '/quran/index';

  @override
  State<IndexSurahPage> createState() => _IndexSurahPageState();
}

class _IndexSurahPageState extends State<IndexSurahPage> {
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
      title: 'Index',
    );
  }

  Expanded _viewItems() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: 15,
          itemBuilder: (context, index) {
            return ItemSurah(
              name: 'Al-Fatihah',
              partName: 'juz 1',
              pageFrom: 1,
              pageTO: 1,
              verses: 7,
              isMakkah: index % 2 == 0,
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
