import 'package:flutter/material.dart';

import 'package:flutter_base/core/utils/constant/utils.dart';
import 'package:flutter_base/core/utils/res/images_app.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/tool_bar_app.dart';
import 'package:flutter_base/modules/home/business_logic/cubit/teachersend_cubit.dart';
import 'package:flutter_base/modules/home/presentation/widget/popup_chose_teacher_send.dart';
import 'package:flutter_base/modules/home/presentation/widget/popup_recitation.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/comment_replay_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class RecitationDetails extends StatefulWidget {
  const RecitationDetails({Key? key}) : super(key: key);

  @override
  State<RecitationDetails> createState() => _RecitationDetailsState();
}

class _RecitationDetailsState extends State<RecitationDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          _topView(context),
          _getItem2(),
        ],
      )),
    );
  }

  Widget _getItem2() {
    return CommentReplayItem(
      isLocal: false,
      isRead: false,
      ayah:
          'بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ (1)الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ (2) الرَّحْمَنِ الرَّحِيمِ (3) مَالِكِ يَوْمِ الدِّينِ (4) إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ (5) اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ (6) صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ (7)',
      ayahInfo: 'الفاتحة من آية رقم 1 الي آية رقم 7',
      userImage: AppImages.duserImage,
      userName: 'userRecitation',
      dateStr: '9:30 15 Nev',
      color: AppColor.transparent,
      trggelPlay: () {},
      recordPath: '',
      wavePath: '',
      errorStr: '',
      isPlay: false,
    );
  }

  Widget _topView(BuildContext context) {
    return ToolBarApp(
      backIcon: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: translate('Recitation Details'),
      actionIcon: IconButton(
          onPressed: () {
            Get.bottomSheet(
              PopupRecitation(
                finish: () {
                  Get.back();
                  Get.bottomSheet(
                    BlocProvider(
                      create: (_) => TeachersendCubit(),
                      child: const PopupChooseTeacherSend(
                        id: 0,
                      ),
                    ),
                  );
                },
                delete: () {},
              ),
              enableDrag: true,
            );
          },
          icon: const Icon(Icons.more_vert)),
    );
  }
}
