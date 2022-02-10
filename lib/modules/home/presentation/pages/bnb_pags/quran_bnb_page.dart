import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/res/images_app.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/text_view.dart';
import 'package:flutter_base/modules/auth_module/presentation/widget/auth_button.dart';
import 'package:flutter_base/modules/home/business_logic/cubit/home_cubit.dart';
import 'package:flutter_base/modules/home/presentation/widget/play_botton.dart';

import 'package:flutter_base/modules/home/presentation/widget/tool_botton.dart';
import 'package:flutter_base/modules/quran/presentation/page/index_surah_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuranBNBPage extends StatelessWidget {
   QuranBNBPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// bottomNavigationBar: rowTools(context),
/*           floatingActionButton: DraggableFab(
        child: CircleAvatar(
          radius: 20,
          backgroundColor: AppColor.darkBlue,
        ),
      ),
  */
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
        var cubit =  HomeCubit.get(context);
          return Stack(
            alignment: Alignment.center,
            children: [
              Stack(
                children: [
                  _viewTop(context),
                  _viewPageReading(context),
                ],
              ),
              Positioned(
                top: 200,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: AuthButton(
                      buttonText: 'on press',
                      width: MediaQuery.of(context).size.width / 2,
                      onPressed: () {
                        cubit.changeIsOnBressed();
                      },
                      colors: [AppColor.darkBlue, AppColor.lightBlue]),
                ),
              ),
              Positioned(
                top: 50,
                child: Row(
                  children:  [
                    if(cubit.isLiked)

                      const Icon(
                      Icons.favorite,
                      color: Colors.amber,
                      size: 40,
                    ),
                    if(cubit.isBookmarked)

                      const Icon(
                      Icons.bookmark,
                      color: Colors.amber,
                      size: 40,
                    ),
                  ],
                ),
              ),
              if(cubit.isRecorded)

                const Positioned(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: RecordTool(),
                ),
              ),
              if(cubit.isOnBressed)

                const Positioned(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ToolBotton(),
                ),
              ),

/*               Positioned(
            bottom: MediaQuery.of(context).size.width / -2,
            right: MediaQuery.of(context).size.width / -2,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width / 2,
              ),
            ),
          )
 */
            ],
          );
        },
      ),
    );
  }

  Widget _viewPageReading(context) {
    return Expanded(
      child: Padding(
        padding:  const EdgeInsets.only(top: 40),
        child: Container(
          decoration:  const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              color: Colors.white),
          child: Column(
            children: [
              Padding(
                padding:  const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextView(
                      text: 'سورة البقرة',
                      textAlign: TextAlign.center,
                      colorText: AppColor.txtColor1,
                      sizeText: 17,
                      padding:  const EdgeInsets.only(top: 12),
                    ),
                    TextView(
                      text: 'الجزء اﻷول',
                      textAlign: TextAlign.center,
                      colorText: AppColor.txtColor1,
                      sizeText: 17,
                      padding:  const EdgeInsets.only(top: 12),
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
      child: GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(IndexSurahPage.routeName),
        onVerticalDragDown: (drag) {
          Navigator.of(context).pushNamed(IndexSurahPage.routeName);
        },
        child: Container(
          padding:  const EdgeInsets.only(bottom: 40, top: 8),
          //margin:  EdgeInsets.only(top: 4),
          decoration: BoxDecoration(
            borderRadius:  const BorderRadius.only(
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
