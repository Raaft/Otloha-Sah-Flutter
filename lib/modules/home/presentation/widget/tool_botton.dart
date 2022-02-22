import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/modules/home/business_logic/cubit/home_cubit.dart';
import 'package:flutter_base/modules/quran/presentation/widget/note_item_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../core/utils/res/icons_app.dart';
import '../../../../core/widgets/alert_dialog_full_screen.dart';

class ToolBotton extends StatefulWidget {
  const ToolBotton({Key? key}) : super(key: key);

  @override
  _ToolBottonState createState() => _ToolBottonState();
}

class _ToolBottonState extends State<ToolBotton> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(listener: (context, state) {
      // TODO: implement listener
    }, builder: (context, state) {
      var cubit = HomeCubit.get(context);
      return Positioned(
          child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 0),
                width: MediaQuery.of(context).size.width / 1.3,
                alignment: Alignment.center,
                height: 45,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 4),
                        blurRadius: 5.0)
                  ],
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.0, 1.1],
                    colors: [AppColor.lightBlue, AppColor.darkBlue],
                  ),
                  color: Colors.deepPurple.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Get.dialog(
                            const AlertDialogFullScreen(),
                            barrierColor: AppColor.backdone,
                          );                        },
                        child: Icon(
                          Icons.copy,
                          color: AppColor.white,
                          //  size: 40,
                        )),
                    GestureDetector(
                        onTap: () {
                          cubit.changeIsLiked();
                        },
                        child: Icon(
                          cubit.isLiked
                              ? Icons.favorite
                              : Icons.favorite_border_outlined,
                          color: AppColor.white,
                          //     size: 40,
                        )),
                    GestureDetector(
                      onTap: () {
                        Scaffold.of(context).showBottomSheet(
                          (context) => const NoteItemView(
                            true,
                            isAdd: true,
                            isQuranPage: true,
                          ),
                          backgroundColor: AppColor.transparent,
                        );
                      },
                      child: Container(
                          padding: const EdgeInsets.only(right: 10, left: 5),
                          height: 50,
                          width: 50,
                          child: Icon(
                            Icons.comment,
                            color: AppColor.white,
                            //  size: 40,
                          )
                          /*Image.asset(
                      AppIcons.quran4Icon,
                      color: AppColor.white,
                    ),*/
                          ),
                    ),
                    GestureDetector(
                        onTap: () {
                          cubit.changeIsBookmarked();
                        },
                        child: Icon(
                          cubit.isBookmarked
                              ? Icons.bookmark
                              : Icons.bookmark_border,
                          color: AppColor.white,
                          // size: 40,
                        )),
                    GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.restart_alt_outlined,
                          color: AppColor.white,
                          //   size: 40,
                        )),
                    GestureDetector(
                        onTap: () {
                          cubit.init().then((value) {
                            cubit.start();
                            cubit.changeIsRecorded();
                          });
                        },
                        child: const Icon(
                          Icons.mic_none_outlined,
                          color: Colors.white,
                          //size: 40,
                        )),
                    GestureDetector(
                      onTap: () {},
                      child: Image.asset(AppIcons.quran2Icon,
                          color: AppColor.white, width: 30),
                    ),
                  ],
                ),
              )));
    });
  }
}
