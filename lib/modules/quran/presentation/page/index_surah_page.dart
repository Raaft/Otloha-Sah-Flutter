import 'package:flutter/material.dart';
import 'package:flutter_base/core/data/chash_helper.dart';
import 'package:flutter_base/core/utils/constant/constants.dart';
import 'package:flutter_base/modules/settings/presentation/widgets/view_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_widget_flutter/quran_widget_flutter.dart';

import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/loading.dart';
import 'package:flutter_base/core/widgets/text_view.dart';
import 'package:flutter_base/modules/home/data/models/utils/init_data.dart';
import 'package:flutter_base/modules/home/presentation/pages/home/home_page.dart';
import 'package:flutter_base/modules/home/presentation/widget/bottom_bar.dart';
import 'package:flutter_base/modules/quran/presentation/widget/item_surah.dart';
import 'package:flutter_base/modules/settings/business_logic/chapter/chapter_cubit.dart';
import 'package:flutter_base/modules/settings/presentation/widgets/search_bar_app.dart';

class IndexSurahPage extends StatefulWidget {
  const IndexSurahPage({Key? key}) : super(key: key);
  static const routeName = '/quran/index';

  @override
  State<IndexSurahPage> createState() => _IndexSurahPageState();
}

class _IndexSurahPageState extends State<IndexSurahPage> {
  int _selected = -1;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ChapterCubit>(context).fetchChaptersList(isSelect: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          BlocBuilder<ChapterCubit, ChapterState>(
            builder: (context, state) {
              if (state is ChapterFetched) {
                return _pageView(state.chapters);
              } else if (state is ChapterInitial) {
                return const LoadingWidget();
              } else {
                return const ViewError(error: '');
              }
            },
          ),
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
                  text: ' سورة ' +
                      (CacheHelper.getData(key: chapterName) ?? 'الفاتحة'),
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

  Column _pageView(List<Chapter>? chapters, {bool isDemo = false}) {
    return Column(
      children: [
        _topView(isDemo),
        _viewItems(chapters),
      ],
    );
  }

  Widget _topView([bool? isDemo]) {
    return SearchBarApp(
      backIcon: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: 'Quran Center',
      onSearch: (val) {
        if (!(isDemo ?? false)) {
          BlocProvider.of<ChapterCubit>(context)
              .fetchChaptersList(qurey: val, isSelect: true);
        }
      },
    );
  }

  SizedBox _viewItems(List<Chapter>? chapters) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: chapters!.length,
          itemBuilder: (context, index) {
            return ItemSurah(
              name: chapters[index].name.toString(),
              partName: '',
              pageFrom: 1,
              pageTO: 1,
              verses: 7,
              isMakkah: index % 2 == 0,
              isSelect: _selected == index,
              onLongPress: () {},
              action: () {
                setState(() {
                  _selected = index;
                });
                CacheHelper.saveData(key: chapterID, value: chapters[index].id);
                CacheHelper.saveData(
                    key: chapterName, value: chapters[index].name);
                _changePage(1);
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
