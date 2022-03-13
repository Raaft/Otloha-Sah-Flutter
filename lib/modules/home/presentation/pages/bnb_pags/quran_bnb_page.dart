import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_widget_flutter/quran_widget_flutter.dart';

import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/text_view.dart';
import 'package:flutter_base/modules/auth_module/presentation/widget/auth_button.dart';
import 'package:flutter_base/modules/home/business_logic/cubit/home_cubit.dart';
import 'package:flutter_base/modules/home/presentation/widget/floatin_button_widget.dart';
import 'package:flutter_base/modules/home/presentation/widget/play_botton.dart';
import 'package:flutter_base/modules/home/presentation/widget/play_puse_tools.dart';
import 'package:flutter_base/modules/home/presentation/widget/recorded_file_setting.dart';
import 'package:flutter_base/modules/home/presentation/widget/tool_botton.dart';
import 'package:flutter_base/modules/quran/presentation/page/index_surah_page.dart';

class QuranBNBPage extends StatefulWidget {
  const QuranBNBPage({Key? key}) : super(key: key);

  @override
  State<QuranBNBPage> createState() => _QuranBNBPageState();
}

class _QuranBNBPageState extends State<QuranBNBPage> {
  int chapter = 1;

  late HomeCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = HomeCubit.get(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Stack(
          alignment: Alignment.center,
          children: [
            Stack(
              children: [
                _viewTop(context),
                _viewPageReading(context),
              ],
            ),
            //_tempView(context, cubit),
            _viewLikeMarked(cubit),
            if (cubit.isRecorded) const RecordTool(),
            if (cubit.isOnPressed || cubit.isSelectedVerse) const ToolBotton(),
            if (cubit.isRecordedFile) const RecordedFileTool(),
            if (cubit.isPlaying) const PlayPauseTools(),
            if (cubit.opacity != 0)
              floatingButton(cubit: cubit, isPressed: cubit.isOnPressed)
          ],
        );
      },
    );
  }

  Widget _viewLikeMarked(HomeCubit cubit) {
    return Positioned(
      top: 50,
      child: Row(
        children: [
          if (cubit.isLiked)
            const Icon(
              Icons.favorite,
              color: Colors.amber,
              size: 40,
            ),
          if (cubit.isBookmarked)
            const Icon(
              Icons.bookmark,
              color: Colors.amber,
              size: 40,
            ),
        ],
      ),
    );
  }

  Widget tempView(BuildContext context, HomeCubit cubit) {
    return Positioned(
      top: 200,
      child: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            AuthButton(
                buttonText: 'on press',
                width: MediaQuery.of(context).size.width / 2,
                onPressed: () {},
                colors: [AppColor.darkBlue, AppColor.lightBlue]),
            AuthButton(
                buttonText: 'on long press',
                width: MediaQuery.of(context).size.width / 2,
                onPressed: () {},
                colors: [AppColor.darkBlue, AppColor.lightBlue]),
          ],
        ),
      ),
    );
  }

  Widget _viewPageReading(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextView(
                    text: ' سورة ' + cubit.chapterN.toString(),
                    textAlign: TextAlign.center,
                    colorText: AppColor.txtColor1,
                    sizeText: 17,
                    padding: const EdgeInsets.only(top: 12),
                  ),
                  TextView(
                    text: cubit.juz,
                    textAlign: TextAlign.center,
                    colorText: AppColor.txtColor1,
                    sizeText: 17,
                    padding: const EdgeInsets.only(top: 12),
                  ),
                ],
              ),
            ),
            //Image.asset(AppImages.page016Image),
            Expanded(
              child: BlocConsumer<HomeCubit, HomeState>(
                listener: (context, state) {},
                builder: (context, state) {
                  print('Chapter Cubit ${cubit.chapterId}');
                  return QuranWidget(
                    page: cubit.pageType,
                    chapterId: cubit.chapterId,
                    bookId: cubit.bookId,
                    narrationId: cubit.narrationId,
                    onTap: (val) {
                      print('onTap ' + val);
                      //cubit.changeIsOnTruePressed();
                      cubit.changeOpacity(.4);
                      Future.delayed(const Duration(seconds: 10), () {
                        //cubit.changeIsOnFalsePressed();
                        cubit.changeOpacity(.0);
                      });
                    },
                    onLongTap: (val) {
                      print('onLongTap ' + val);
                      cubit.changeIsSelectedVerse();
                    },
                    getPage: (page) {
                      cubit.changeJuz(page.partId ?? 1);
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _viewTop(BuildContext context) {
    return Hero(
      tag: 'ToChooseSurah',
      child: GestureDetector(
        onTap: () => Navigator.of(context)
            .pushNamed(IndexSurahPage.routeName)
            .then((value) {
          cubit.changeChapter(value as int);
        }),
        child: Container(
          padding: const EdgeInsets.only(bottom: 40, top: 8),
          //margin:  EdgeInsets.only(top: 4),
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
                text: ' سورة ' + (cubit.chapterN ?? 'الفاتحة'),
                textAlign: TextAlign.center,
                colorText: AppColor.txtColor2,
                sizeText: 17,
              ),
              Icon(
                Icons.expand_more,
                color: AppColor.txtColor2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
///////////commit proplem
