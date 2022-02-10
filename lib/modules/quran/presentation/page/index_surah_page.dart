import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/text_view.dart';
import 'package:flutter_base/core/widgets/tool_bar_app.dart';
import 'package:flutter_base/modules/home/data/models/utils/init_data.dart';
import 'package:flutter_base/modules/home/presentation/pages/home/home_page.dart';
import 'package:flutter_base/modules/home/presentation/widget/bottom_bar.dart';
import 'package:flutter_base/modules/quran/presentation/widget/item_surah.dart';

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
          child: Stack(
        children: [
          _pageView(),
          _viewTop(context),
        ],
      )),
      bottomNavigationBar: BubbleBottomBarApp(
        onItemTapped: _changePage,
        selectedIndex: 1,
        items: homeMenuItems,
      ),
    );
  }

  Widget _viewTop(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Hero(
        tag: 'ToChooseSurah',
        child: GestureDetector(
          onTap: () => _changePage(1),
          child: Container(
            padding: const EdgeInsets.all(8),
            //margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              color: AppColor.darkBlue,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextView(
                  text: '2. Al-Baqarah',
                  textAlign: TextAlign.center,
                  colorText: AppColor.txtColor2,
                  sizeText: 17,
                ),
                Icon(
                  Icons.expand_less,
                  color: AppColor.txtColor2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _pageView() {
    return Column(
      children: [_topView(), _viewItems()],
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

  _changePage(int? index) {
    Navigator.of(context)
        .pushReplacementNamed(HomePage.routeName, arguments: index);
  }
}
