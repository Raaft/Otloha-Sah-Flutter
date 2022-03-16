import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/constant/utils.dart';
import 'package:flutter_base/core/utils/res/images_app.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/tool_bar_app.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/selectable_message_item.dart';

class ReplayMesaagePage extends StatelessWidget {
  const ReplayMesaagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            _topView(context),
            messageDetailsNew(context),
          ],
        ),
      ),
    );
  }

  messageDetailsNew(BuildContext context) {
    return SelectableMessageItem(
      ayah:
          'بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ (1)الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ (2) الرَّحْمَنِ الرَّحِيمِ (3) مَالِكِ يَوْمِ الدِّينِ (4) إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ (5) اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ (6) صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ (7)',
      ayahInfo: 'الفاتحة من آية رقم 1 الي آية رقم 7',
      userImage: AppImages.duserImage,
      userName: 'userRecitation',
      dateStr: '9:30 15 Nev',
      color: AppColor.transparent, isRead: false, isCertic: false,
      selectedText: (txt) {
        print('Seleceted Text $txt');
      },
      // overflow: TextOverflow.ellipsis,
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
      title: translate('أضافة تعليق جديد'),
    );
  }
}
