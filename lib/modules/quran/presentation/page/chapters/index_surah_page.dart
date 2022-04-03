import 'package:flutter/material.dart';
import '../../../../../data_source/cache_helper.dart';
import '../../../../../core/utils/constant/constants.dart';
import '../../../../home/presentation/widget/init_data.dart';
import '../../../../settings/presentation/widgets/view_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_widget_flutter/quran_widget_flutter.dart';

import '../../../../../core/utils/themes/color.dart';
import '../../../../../core/widgets/loading.dart';
import '../../../../../core/widgets/text_view.dart';
import '../../../../home/presentation/widget/bottom_bar.dart';
import '../../widget/item_surah.dart';
import '../../../../settings/business_logic/chapter/chapter_cubit.dart';
import '../../../../settings/presentation/widgets/search_bar_app.dart';

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
    BlocProvider.of<ChapterCubit>(context).fetchChaptersList(
      isSelect: true,
    );
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
                      (CacheHelper.getData(key: chapterSelectedName) ??
                          'الفاتحة'),
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

  Widget _viewItems(List<Chapter>? chapters) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: MediaQuery.of(context).size.height * 0.8,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: chapters!.length,
        itemBuilder: (context, index) {
          return ItemSurah(
            name: chapters[index].name.toString(),
            partName: '',
            pageFrom: chapters[index].pageFrom ?? 1,
            pageTO: chapters[index].pageTo ?? 1,
            verses: chapters[index].versesSize ?? 7,
            isMakkah: _getOorigin(chapters[index].origin),
            isSelect: _selected == index,
            onLongPress: () {},
            action: () {
              setState(() {
                _selected = index;
              });
              CacheHelper.saveData(
                  key: chapterSelectedID, value: chapters[index].id);
              CacheHelper.saveData(
                  key: chapterSelectedName, value: chapters[index].name);
              _changePage(1);
            },
          );
        },
      ),
    );
  }

  _changePage(int? index) {
    Navigator.of(context).pop();
  }

  _getOorigin(String? origin) {
    if (origin == 'maka') {
      return true;
    }
    return false;
  }
}
