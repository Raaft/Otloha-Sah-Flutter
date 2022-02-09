import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/res/images_app.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/text_view.dart';
import 'package:flutter_base/modules/quran/presentation/page/index_surah_page.dart';

class QuranBNBPage extends StatelessWidget {
  const QuranBNBPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _viewTop(context),
        _viewPageReading(),
      ],
    );
  }

  Widget _viewPageReading() {
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
              Image.asset(AppImages.page016Image),
            ],
          ),
        ),
      ),
    );
  }

  Widget _viewTop(BuildContext context) {
    return Hero(
      tag: 'ToChooseSurah',
      child: Container(
        padding: const EdgeInsets.only(bottom: 40, top: 8),
        //margin: const EdgeInsets.only(top: 4),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          image: DecorationImage(
            image: AssetImage(AppImages.back2Image),
            fit: BoxFit.cover,
          ),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(IndexSurahPage.routeName);
          },
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
