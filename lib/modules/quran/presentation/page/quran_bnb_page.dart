import 'package:flutter/material.dart';
import '../../../../core/utils/themes/color.dart';
import '../../../../core/widgets/text_view.dart';
import '../../../home/business_logic/cubit/home_cubit.dart';
import '../../business_logic/cubit/quran_cubit.dart';
import '../../business_logic/cubit/recitation_cubit.dart';
import 'chapters/index_surah_page.dart';
import '../widget/floatin_button_widget.dart';
import '../widget/play_botton.dart';
import '../widget/play_puse_tools.dart';
import '../widget/recorded_file_setting.dart';
import '../widget/tool_botton.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_widget_flutter/quran_widget_flutter.dart';

class QuranBNBPage extends StatelessWidget {


  int chapter = 1;

  QuranViewCubit? cubit;
  RecitationAddCubit? addCubit;


  @override
  Widget build(BuildContext context) {
    cubit = QuranViewCubit.get(context);
    addCubit = RecitationAddCubit.get(context);
    return BlocConsumer<QuranViewCubit, QuranViewState>(
      listener: (context, state) {},
      builder: (context, state) {

        var cubit = QuranViewCubit.get(context);
        var homeCubit = HomeCubit.get(context);
        return Scaffold(
          body: Stack(
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
              if (cubit.checkVersesValue &&
                  cubit.isPlaying == false &&
                  cubit.isRecorded == false &&
                  cubit.isRecordedFile == false)
                if (cubit.checkVersesValue && cubit.isPlaying == false)
                  const ToolBotton(),
              if (cubit.isRecordedFile) const RecordedFileTool(),
              if (cubit.isPlaying) const PlayPauseTools(),
              if (cubit.opacity != 0)
                floatingButton(
                    cubit: cubit,
                    isPressed: cubit.isOnPressed,
                    homeCubit: homeCubit)
            ],
          ),
        );
      },
    );
  }

  Widget _viewLikeMarked(QuranViewCubit cubit) {
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
                    text: ' سورة ' + (cubit!.chapterName ?? 'الفاتحة'),
                    textAlign: TextAlign.center,
                    colorText: AppColor.txtColor1,
                    sizeText: 17,
                    padding: const EdgeInsets.only(top: 12),
                  ),
                  TextView(
                    text: cubit!.juz,
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
              child: BlocBuilder<QuranViewCubit, QuranViewState>(
                builder: (context, state) {
                  print('Chapter Cubit ${cubit!.chapterId}');
                  return QuranWidget(
                    page: cubit!.pageType,
                    chapterId: cubit!.chapterId,
                    bookId: cubit!.bookId,
                    narrationId: cubit!.narrationId,
                    onTap: (val, isVerSelected, values, selectedVerses) {
                      print('onTap ' + val);
                      // cubit.changeIsOnTruePressed();
                      cubit!.changeOpacity(.5);

                      //print(selectedVerses);
                      addCubit!.setSelectedVerses(selectedVerses!);
                      cubit!.setSelectedVerses(selectedVerses);
                      print('Get Name ' + cubit!.getName());
                      cubit!.isVerSelected(isVerSelected);
                      Future.delayed(const Duration(seconds: 5), () {
                        cubit!.changeOpacity(.2);
                      });
                    },
                    onLongTap: (val, isVerSelected, values, selectedVerses) {
                      print('onLongTap ' + val);
                      cubit!.isVerSelected(isVerSelected);

                      cubit!.changeIsSelectedVerse();
                      cubit!.changeIsOnTruePressed();
                      addCubit!.setSelectedVerses(selectedVerses!);
                      cubit!.setSelectedVerses(selectedVerses);
                      print('Get Name ' + cubit!.getName());
                    },
                    getPage: (page) {
                      print('Oloha ' + page.toString());
                      cubit!.changeJuz(
                          page.partId ?? 1, page.chapters![0].id ?? 1, page);
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
          cubit!.changeChapter((value ?? 1) as int);
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
                text: ' سورة ' + (cubit!.chapterName ?? 'الفاتحة'),
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
