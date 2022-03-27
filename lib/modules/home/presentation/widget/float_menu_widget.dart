import 'package:flutter/material.dart';
import 'package:flutter_base/modules/data/model/page_marked.dart';
import 'package:flutter_base/modules/data/model/verse_like.dart';
import 'package:flutter_base/modules/data/model/verse_note.dart';
import 'package:flutter_base/modules/data/repository/database_repository.dart';

import 'package:flutter_base/modules/settings/presentation/pages/settings_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:quran_widget_flutter/quran_widget_flutter.dart';

import '../../../../core/utils/res/icons_app.dart';
import '../../../../core/utils/themes/color.dart';
import '../../business_logic/cubit/home_cubit.dart';

class FloatingMenu extends StatelessWidget {
  const FloatingMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Stack(
          children: [
            floatBackGround(cubit),
            floatBall(context, cubit),
          ],
        );
      },
    );
  }
}

/*Widget floatMenu(BuildContext context, HomeCubit cubit) {
  return Stack(
    children: [
      floatBackGround(cubit),
      floatBall(context, cubit),
    ],
  );
}
*/
Positioned floatBall(BuildContext context, HomeCubit cubit) {
  return Positioned(
    bottom: MediaQuery.of(context).size.width / -2,
    right: MediaQuery.of(context).size.width / -2,
    child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [
                  AppColor.lightBlue.withOpacity(.7),
                  AppColor.darkBlue.withOpacity(1),
                ], begin: Alignment.bottomLeft, end: Alignment.topRight)),
            child: Stack(
              children: [
                CircleAvatar(
                  backgroundColor: AppColor.transparent,
                  radius: (MediaQuery.of(context).size.width / 2 < 200)
                      ? 200
                      : MediaQuery.of(context).size.width / 2,
                ),
                Positioned(
                  top: 40,
                  left: 20,
                  child: Container(
                    color: AppColor.transparent,
                    height: 150,
                    width: 175,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 30,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(width: 15),
                                if (cubit.pageType != PageType.quran)
                                  GestureDetector(
                                    onTap: () {
                                      cubit.changePluginPage(
                                          page: PageType.quran);
                                      cubit.changeFalseFloating();
                                    },
                                    child: Image.asset(AppIcons.quran2Icon,
                                        color: AppColor.white, width: 30),
                                  ),
                                const SizedBox(width: 15),
                                if (cubit.pageType != PageType.tajwid)
                                  GestureDetector(
                                    onTap: () {
                                      cubit.changePluginPage(
                                          page: PageType.tajwid);
                                      cubit.changeFalseFloating();
                                    },
                                    child: Image.asset(AppIcons.discussioncon,
                                        color: AppColor.white, width: 30),
                                  ),
                                const SizedBox(
                                  width: 20,
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (cubit.pageType != PageType.tafsir)
                                GestureDetector(
                                  onTap: () {
                                    cubit.changePluginPage(
                                        page: PageType.tafsir);
                                    cubit.changeFalseFloating();
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.only(
                                          right: 10, left: 5),
                                      height: 50,
                                      width: 50,
                                      child: Image.asset(
                                        AppIcons.quran4Icon,
                                        color: AppColor.white,
                                        width: 30,
                                      )),
                                ),
                              GestureDetector(
                                  onTap: () {
                                    cubit.changeIsBookmarked();
                                    cubit.getChapterName(
                                            chapterId: cubit
                                                .page!.chapters![0].chapterId).then((value) {
                                      DatabaseRepository()
                                          .insertPageMarked(PageMarked(
                                        idBook: 2,
                                        pageNumber: cubit.page!.id,
                                        textVerse: cubit.myChapter!.name,
                                        idPage: cubit.page!.id ,
                                      ));
                                    });
                                  },
                                  child: Icon(
                                    cubit.isBookmarked
                                        ? Icons.bookmark
                                        : Icons.bookmark_border,
                                    color: AppColor.white,
                                    size: 35,
                                  )),
                              GestureDetector(
                                onTap: () {},
                                child: Image.asset(AppIcons.playIcon,
                                    color: AppColor.white, width: 30),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    cubit.changeIsLiked();
                                    DatabaseRepository()
                                        .insertVerseLiked(VerseLiked(
                                      idFromVerse: 1,
                                      pageNumber: 20,
                                      textFristVerse:
                                          'قُلْ هُوَ اللَّهُ أَحَدٌ',
                                      idToVerse: 2,
                                      idPage: 20,
                                    ));
                                  },
                                  child: Icon(
                                    cubit.isLiked
                                        ? Icons.favorite
                                        : Icons.favorite_border_outlined,
                                    color: AppColor.white,
                                    size: 35,
                                  )),
                            ],
                          ),
                        ),
                        if (cubit.pageType != PageType.translation)
                          SizedBox(
                            height: 30,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      cubit.changePluginPage(
                                          page: PageType.translation);
                                      cubit.changeFalseFloating();
                                    },
                                    child: Icon(
                                      Icons.translate,
                                      color: AppColor.white,
                                      size: 30,
                                    )),
                                GestureDetector(
                                    onTap: () {
                                      DatabaseRepository()
                                          .insertVerseNote(VerseNote(
                                        idFromVerse: 1,
                                        pageNumber: 20,
                                        textFristVerse:
                                            'قُلْ هُوَ اللَّهُ أَحَدٌ',
                                        idToVerse: 2,
                                        noteText: 'My Note',
                                        idPage: 20,
                                      ));
                                    },
                                    child: Icon(
                                      Icons.comment_outlined,
                                      color: AppColor.white,
                                      size: 30,
                                    )),
                                GestureDetector(
                                  onTap: () {},
                                  child: Image.asset(AppIcons.shareIcon,
                                      color: AppColor.white, width: 30),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      Get.to(const SettingsPage());
                                    },
                                    child: Icon(
                                      Icons.settings,
                                      color: AppColor.white,
                                      size: 35,
                                    )),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ))),
  );
}

GestureDetector floatBackGround(HomeCubit cubit) {
  return GestureDetector(
    onTap: () {
      cubit.changeIsOnTruePressed();
      cubit.changeOpacity(1);
      Future.delayed(const Duration(seconds: 5), () {
        cubit.changeIsOnFalsePressed();
        cubit.changeOpacity(.2);
      });
    },
    child: Container(
      color: AppColor.backdone,
    ),
  );
}
