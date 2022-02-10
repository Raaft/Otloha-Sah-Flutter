import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/res/icons_app.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/text_view.dart';
import 'package:flutter_base/modules/auth_module/presentation/widget/auth_button.dart';
import 'package:flutter_base/modules/quran/presentation/page/index_surah_page.dart';

class QuranBNBPage extends StatelessWidget {
  const QuranBNBPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: rowTools(context),
      floatingActionButton: DraggableFab(
        child: CircleAvatar(
          radius: 20,
          backgroundColor: AppColor.darkBlue,
        ),
      ),
      body: Stack(
        children: [
          _viewTop(context),
          _viewPageReading(context),
          Positioned(
            bottom: MediaQuery.of(context).size.width / -2,
            right: MediaQuery.of(context).size.width / -2,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width / 2,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _viewPageReading(context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              color: Colors.white),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextView(
                      text: 'سورة البقرة',
                      textAlign: TextAlign.center,
                      colorText: AppColor.txtColor1,
                      sizeText: 17,
                      padding: const EdgeInsets.only(top: 12),
                    ),
                    TextView(
                      text: 'الجزء اﻷول',
                      textAlign: TextAlign.center,
                      colorText: AppColor.txtColor1,
                      sizeText: 17,
                      padding: const EdgeInsets.only(top: 12),
                    ),
                  ],
                ),
              ),
/*
       Image.asset(AppImages.page016Image),


*/
              Column(
                children: [
                  AuthButton(
                      buttonText: 'on press',
                      width: MediaQuery.of(context).size.width / 2,
                      onPressed: () {},
                      colors: [AppColor.darkBlue, AppColor.lightBlue]),
                  AuthButton(
                      buttonText: 'on Long Pressed',
                      width: MediaQuery.of(context).size.width / 2,
                      onPressed: () {},
                      colors: [AppColor.darkBlue, AppColor.lightBlue]),
                  AuthButton(
                      buttonText: 'on double press',
                      width: MediaQuery.of(context).size.width / 2,
                      onPressed: () {},
                      colors: [AppColor.darkBlue, AppColor.lightBlue]),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _viewTop(BuildContext context) {
    return Hero(
      tag: 'ToChooseSurah',
      child: GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(IndexSurahPage.routeName),
        onVerticalDragDown: (drag) {
          Navigator.of(context).pushNamed(IndexSurahPage.routeName);
        },
        child: Container(
          padding: const EdgeInsets.only(bottom: 40, top: 8),
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

Widget rowTools(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const SizedBox(width: 10),
      Container(
        //margin: const EdgeInsets.symmetric(horizontal: 0),
        // width: MediaQuery.of(context).size.width/4,

        alignment: Alignment.center,
        height: 50,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
          ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.0, 1.1],
            colors: [AppColor.darkBlue, AppColor.lightBlue],
          ),
          color: Colors.deepPurple.shade300,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.only(right: 10, left: 5),
                height: 50,
                width: 50,
                child: Image.asset(
                  AppIcons.quran4Icon,
                  color: AppColor.white,
                ),
              ),
            ),
            GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.copy,
                  color: AppColor.white,
                  size: 40,
                )),
            GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.comment_bank_outlined,
                  color: AppColor.white,
                  size: 40,
                )),
            GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.file_upload_outlined,
                  color: AppColor.white,
                  size: 40,
                )),
            GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.forward_10_outlined,
                  color: AppColor.white,
                  size: 40,
                )),
            GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.mic_none_outlined,
                  color: Colors.red,
                  size: 40,
                )),
            GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.play_arrow_outlined,
                  color: AppColor.white,
                  size: 40,
                )),
          ],
        ),
      ),
      const SizedBox(width: 10),
    ],
  );
}
