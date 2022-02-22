import 'package:flutter/material.dart';
import 'package:flutter_base/modules/data/model/page_marked.dart';
import 'package:flutter_base/modules/data/model/verse_like.dart';
import 'package:flutter_base/modules/data/model/verse_note.dart';
import 'package:flutter_base/modules/data/repository/database_repository.dart';

import 'package:flutter_base/modules/settings/presentation/pages/settings_page.dart';
import 'package:get/get.dart';

import '../../../../core/utils/res/icons_app.dart';
import '../../../../core/utils/themes/color.dart';
import '../../../../core/widgets/alert_dialog_full_screen.dart';
import '../../business_logic/cubit/home_cubit.dart';

Widget floatMenu(BuildContext context, HomeCubit cubit) {
  return Positioned(
    bottom: MediaQuery
        .of(context)
        .size
        .width / -2,
    right: MediaQuery
        .of(context)
        .size
        .width / -2,
    child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [
                  AppColor.lightBlue.withOpacity(.5),
                  AppColor.darkBlue.withOpacity(.9),
                ], begin: Alignment.bottomLeft, end: Alignment.topRight)),
            child: Stack(
              children: [
                CircleAvatar(
                  backgroundColor: AppColor.transparent,
                  radius: MediaQuery
                      .of(context)
                      .size
                      .width / 2,
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Image.asset(AppIcons.quran4Icon,
                                    color: AppColor.white, width: 30),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.dialog(
                                    const AlertDialogFullScreen(),
                                    barrierColor: AppColor.backdone,
                                  );
                                },
                                child: const Icon(Icons.copy,color: Colors.white,),
                              ),
                              const SizedBox(
                                width: 20,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                    padding: const EdgeInsets.only(
                                        right: 10, left: 5),
                                    height: 50,
                                    width: 50,
                                    child: Image.asset(
                                      AppIcons.quran2Icon,
                                      color: AppColor.white,
                                      width: 30,
                                    )),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    cubit.changeIsBookmarked();
                                    DatabaseRepository().insertPageMarked(
                                        PageMarked(idBook: 2,
                                          pageNumber: 20,
                                          text: 'قُلْ هُوَ اللَّهُ أَحَدٌ',
                                          idPage: 20,));
                                  },
                                  child: Icon(
                                    cubit.isBookmarked
                                        ? Icons.bookmark
                                        : Icons.bookmark_border,
                                    color: AppColor.white,
                                    size: 30,
                                  )),
                              GestureDetector(
                                onTap: () {},
                                child: Image.asset(AppIcons.playIcon,
                                    color: AppColor.white, width: 30),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    cubit.changeIsLiked();
                                    DatabaseRepository().insertVerseLiked(
                                        VerseLiked(
                                          idFromVerse: 1,
                                          pageNumber: 20,
                                          textFristVerse: 'قُلْ هُوَ اللَّهُ أَحَدٌ',
                                          idToVerse: 2,

                                          idPage: 20,

                                        ));
                                  },
                                  child: Icon(
                                    cubit.isLiked
                                        ? Icons.favorite
                                        : Icons.favorite_border_outlined,
                                    color: AppColor.white,
                                    size: 30,
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    cubit.changeIsBookmarked();
                                  },
                                  child: Icon(
                                    Icons.translate,
                                    color: AppColor.white,
                                    size: 30,
                                  )),
                              GestureDetector(
                                  onTap: () {
                                    DatabaseRepository().insertVerseNote(
                                        VerseNote(
                                          idFromVerse: 1,
                                          pageNumber: 20,
                                          textFristVerse: 'قُلْ هُوَ اللَّهُ أَحَدٌ',
                                          idToVerse: 2,
                                          noteText: 'My Note',

                                          idPage: 20,));

                                  },
                                  child: Icon(
                                    Icons.comment,
                                    color: AppColor.white,
                                    size: 30,
                                  )),
                              GestureDetector(
                                  onTap: () {

                                  },
                                  child: Icon(
                                    Icons.outbox,
                                    color: AppColor.white,
                                    size: 30,
                                  )),
                              GestureDetector(
                                  onTap: () {
                                    Get.to(const SettingsPage());
                                  },
                                  child: Icon(
                                    Icons.settings,
                                    color: AppColor.white,
                                    size: 30,
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


////proplr in commit