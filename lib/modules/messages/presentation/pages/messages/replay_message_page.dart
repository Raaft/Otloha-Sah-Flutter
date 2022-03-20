import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/constant/utils.dart';
import 'package:flutter_base/core/utils/res/images_app.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/tool_bar_app.dart';
import 'package:flutter_base/modules/messages/business_logic/cubit/reply_cubit.dart';
import 'package:flutter_base/modules/messages/business_logic/cubit/reply_state.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/selectable_message_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReplayMesaagePage extends StatelessWidget {
  const ReplayMesaagePage({Key? key}) : super(key: key);
  static const routeName = '/message/replay';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ReplyCubit(),
        child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                _topView(context),
                Expanded(child: messageDetailsNew(context)),
                _messageField(),
              ],
            ),
          ),
        ));
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

  _messageField() => BlocConsumer<ReplyCubit, ReplyState>(
      listener: (context, state) {},
      builder: (context, state) {
        ReplyCubit cubit = ReplyCubit.get(context);
        return Container(
          margin: const EdgeInsets.all(15.0),
          height: 61,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(35.0),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 3),
                        blurRadius: 5,
                        color: Colors.grey,
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: cubit.messageController,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      if (state is StartRecordingState)
                        IconButton(
                          icon: const Icon(
                            Icons.stop_circle,
                            color: Colors.blueAccent,
                          ),
                          onPressed: () {
                            cubit.stop();
                          },
                        ),
                      if (state is EndRecordingState)
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.blueAccent,
                              ),
                              onPressed: () {
                                cubit.delete();
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.play_arrow,
                                color: Colors.blueAccent,
                              ),
                              onPressed: () {
                                cubit.onPlayAudio();
                              },
                            ),
                          ],
                        ),
                      if (state is InitialReplyState ||
                          state is DeleteRecordState)
                        IconButton(
                          icon: Icon(
                            Icons.mic,
                            color: Colors.blueAccent,
                          ),
                          onPressed: () {
                            cubit.start();
                          },
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Container(
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                    color: Colors.blueAccent, shape: BoxShape.circle),
                child: InkWell(
                  child: Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                  onLongPress: () {},
                ),
              ),
            ],
          ),
        );
      });
}
