import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/constant/utils.dart';
import 'package:flutter_base/core/utils/res/images_app.dart';
import 'package:flutter_base/core/widgets/tool_bar_app.dart';
import 'package:flutter_base/modules/messages/business_logic/cubit/reply_cubit.dart';
import 'package:flutter_base/modules/messages/presentation/pages/messages/replay_message_page.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/comment_replay_item.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/general_message_item.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/mesage_detalails_record.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/mesage_detalis_head.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/message_item_sub.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get/get.dart';

import 'package:flutter_base/core/utils/themes/color.dart';

import 'package:flutter_base/core/widgets/text_view.dart';

class MessageDetails extends StatefulWidget {
  const MessageDetails({Key? key}) : super(key: key);

  @override
  State<MessageDetails> createState() => _MessageDetailsState();
}

class _MessageDetailsState extends State<MessageDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          //  crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _topView(context),
            messageDetailsNew(context),
            _viewTitle(),
            _viewData()
          ],
        ),
      ),
    );
  }

  ListView _viewData() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 15,
      itemBuilder: (context, index) => _viewItem(index),
    );
  }

  Widget _viewTitle() {
    return SizedBox(
      width: double.infinity,
      child: TextView(
        text: 'التعليقات ...',
        weightText: FontWeight.bold,
        padding: const EdgeInsets.all(16),
        sizeText: 15,
        textAlign: TextAlign.start,
        colorText: AppColor.darkBlue,
      ),
    );
  }

  Widget _topView(BuildContext ctx) {
    return ToolBarApp(
      backIcon: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(ctx).pop();
        },
      ),
      title: translate('تفاصيل الرسالة'),
    );
  }

  Widget messageReplay() {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      const SizedBox(),
      MessageDetailsReplay(
        userName: 'Shady',
        verText: 'Text of messageText of messageT',
        action: () {},
        isCertified: true,
      ),
      const MessageDetailsRecord(
        recordPath: '',
        wavePath: '',
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextView(
            text: 'Comment',
            padding: const EdgeInsets.all(0),
            sizeText: 16,
            colorText: AppColor.txtColor4,
            weightText: FontWeight.w600,
            textAlign: TextAlign.center,
            //overflow: TextOverflow.ellipsis,
          ),
          TextView(
            text: 'Add Replay',
            padding: const EdgeInsets.all(0),
            sizeText: 15,
            colorText: AppColor.darkBlue,
            weightText: FontWeight.w600,
            textAlign: TextAlign.center,
            action: () {},
            //overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ]);
  }

  messageDetailsNew(BuildContext context) {
    return GeneralMessageItem(
      isLocal: false,
      boxMessageItem: SubMessageItem(
        isRead: false,
        ayah:
            'بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ (1)الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ (2) الرَّحْمَنِ الرَّحِيمِ (3) مَالِكِ يَوْمِ الدِّينِ (4) إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ (5) اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ (6) صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ (7)',
        ayahInfo: 'الفاتحة من آية رقم 1 الي آية رقم 7',
        userImage: AppImages.duserImage,
        userName: 'userRecitation',
        dateStr: '9:30 15 Nev',
        color: AppColor.transparent,
      ),
      isLike: true,
      likeCount: 20,
      trggelPlay: () {},
      margin: 0,
      viewBottom: false,
      replay: SizedBox(
        width: double.infinity,
        child: TextView(
          text: 'رد',
          padding: const EdgeInsets.symmetric(horizontal: 8),
          sizeText: 14,
          weightText: FontWeight.w700,
          colorText: AppColor.txtColor4,
          textAlign: TextAlign.start,
          action: () {
            Get.to(
              BlocProvider(
                create: (context) => ReplyCubit(),
                child: const ReplayMessagePage(),
              ),
            );
          },
          // overflow: TextOverflow.ellipsis,
        ),
      ),
      recordPath: '',
      wavePath: '',
    );
  }

  _viewItem(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      //TODO add wave files
      child: CommentReplayItem(
        isRead: false,
        ayah: 'الصِّرَاطَ ',
        ayahInfo: 'الفاتحة آية رقم 7',
        userImage: AppImages.duserImage,
        userName: 'userRecitation',
        dateStr: '9:30 15 Nev',
        color: AppColor.selectColor1,
        isPlay: false,
        trggelPlay: () {},
        isReplay: index % 3 == 1,
        recordPath: '',
        wavePath: '',
        errorStr:
            'هذا الملف يحتوي على معلومات إضافية، غالبا ما تكون أضيفت من قبل الكاميرا الرقمية أو الماسح الضوئي المستخدم في إنشاء الملف.إذا كان الملف قد عدل عن حالته الأصلية، فبعض التفاصيل قد لا تعبر عن الملف المعدل.',
      ),
    );
  }
}
