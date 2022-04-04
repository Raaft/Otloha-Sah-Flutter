import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/utils/res/icons_app.dart';
import '../../../../core/utils/themes/color.dart';
import '../../../../core/widgets/alert_dialog_full_screen.dart';
import '../../../../data_source/local/database/database_repository.dart';
import '../../../../data_source/models/database_model/verse_like.dart';
import 'add_note.dart';
import '../../business_logic/cubit/quran_cubit.dart';
import '../../business_logic/cubit/recitation_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:quran_widget_flutter/model/verse.dart';

class ToolBotton extends StatefulWidget {
  const ToolBotton({Key? key}) : super(key: key);

  @override
  _ToolBottonState createState() => _ToolBottonState();
}

class _ToolBottonState extends State<ToolBotton> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuranViewCubit, QuranViewState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = QuranViewCubit.get(context);
        var cubitRecitation = RecitationAddCubit.get(context);
        return Positioned(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 0),
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 1.09,
              alignment: Alignment.center,
              height: 45,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 4),
                    blurRadius: 5.0,
                  )
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
                        cubit.changeIsPlaying();
                      },
                      child: Image.asset(
                        AppIcons.playIcon,
                        color: AppColor.white,
                        height: 30,
                      )),
                  if (!cubit.isSelectedVerse)
                    GestureDetector(
                        onTap: () async {
                          await cubitRecitation.init();
                          await cubit.changeIsRecorded();
                          await cubitRecitation.start();
                        },
                        child: const Icon(
                          Icons.mic_none_outlined,
                          color: Colors.white,
                          size: 30,
                        )),
                  if (cubit.isSelectedVerse)
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.restart_alt_outlined,
                        color: AppColor.white,
                        size: 30,
                      ),
                    ),
                  // if (cubit.isSelectedVerse)
                  GestureDetector(
                    onTap: () {
                      Scaffold.of(context).showBottomSheet(
                            (context) =>
                            AddNote(
                              text:cubit.selectedVerses[0].text,
                              idPage: cubit.selectedVerses[0].id,
                              title: '',
                              textFristVerse: cubit.getFirstWords(
                                  cubit.selectedVerses.first.uthmanicText ?? '',
                                  5),
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
                        )),
                  ),
                  GestureDetector(
                    onTap: () {
                      String verses = '';
                      for (Verse verse in cubit.selectedVerses) {
                        verses += ' ${verse.text}';
                      }
                      Clipboard.setData(ClipboardData(text: verses));
                      Get.dialog(
                        const AlertDialogFullScreen(),
                        barrierColor: AppColor.backdone,
                      );
                    },
                    child: const Icon(
                      Icons.copy,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      cubit.changeIsLiked();

                      DatabaseRepository().insertVerseLiked(
                        VerseLiked(
                          idFromVerse: cubit.selectedVerses.first.id,
                          pageNumber: 20,
                          textFristVerse: cubit.getFirstWords(
                              cubit.selectedVerses.first.uthmanicText ?? '', 5),
                          idToVerse: cubit.selectedVerses.first.id,
                          idPage: cubit.page!.id,
                        ),
                      );
                    },
                    child: Icon(
                      cubit.isLiked
                          ? Icons.favorite
                          : Icons.favorite_border_outlined,
                      color: AppColor.white,
                      size: 30,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset(AppIcons.languageIcon,
                        color: AppColor.white, width: 30),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset(AppIcons.discussioncon,
                        color: AppColor.white, width: 30),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset(AppIcons.quran4Icon,
                        color: AppColor.white, width: 30),
                  ),
                  /*  
                        GestureDetector(
                          onTap: () {},
                          child: Image.asset(AppIcons.quran2Icon,
                              color: AppColor.white, width: 30),
                        ),*/
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
