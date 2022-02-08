import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/core/utils/constant/utils.dart';
import 'package:flutter_base/core/utils/res/images_app.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/tool_bar_app.dart';
import 'package:flutter_base/core/widgets/text_view.dart';
import 'package:flutter_base/modules/messages/business_logic/cubit/messagetap_cubit.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/box_message_item.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/general_message_item.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/item_user_messages.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_waveform/just_waveform.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  static const routeName = '/message';

  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  int _selected = 0;

  final BehaviorSubject<WaveformProgress> progressStream =
      BehaviorSubject<WaveformProgress>();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, _init);
  }

  Future<void> _init() async {
    final audioFile =
        File(p.join((await getTemporaryDirectory()).path, 'waveform.mp3'));
    try {
      await audioFile.writeAsBytes(
          (await rootBundle.load('assets/audio/waveform.mp3'))
              .buffer
              .asUint8List());
      final waveFile =
          File(p.join((await getTemporaryDirectory()).path, 'waveform.wave'));

      JustWaveform.extract(audioInFile: audioFile, waveOutFile: waveFile)
          .listen(progressStream.add, onError: progressStream.addError);

      //    JustWaveform.parse(waveFile);
    } catch (e) {
      debugPrint('Eror audio' + e.toString());
      progressStream.addError(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<MessageTapCubit, MessageTapState>(
          builder: (context, state) {
            if (state is MessageTapChange) {
              _selected = state.index;
            }

            return Column(
              children: [
                _topView(),
                _tabsView(),
                _viewItems(),
              ],
            );
          },
        ),
      ),
    );
  }

  Expanded _viewItems() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: 15,
          itemBuilder: (context, index) {
            return _getItem(index);
          },
        ),
      ),
    );
  }

  Row _tabsView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _tabItem('General', 0, isSelect: _selected == 0),
        _divider(),
        _tabItem('Inbox', 1, isSelect: _selected == 1),
        _divider(),
        _tabItem('Outbox', 2, isSelect: _selected == 2),
        _divider(),
        _tabItem('Private', 3, isSelect: _selected == 3),
      ],
    );
  }

  SizedBox _divider() {
    return SizedBox(
      width: 1.5,
      child: Divider(
        thickness: 16,
        color: AppColor.txtColor4,
      ),
    );
  }

  Widget _tabItem(String title, int value, {bool isSelect = false}) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<MessageTapCubit>(context).changeIndex(value);
      },
      child: Container(
        decoration: isSelect
            ? BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColor.gradient5, AppColor.gradient6],
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                ),
                borderRadius: BorderRadius.circular(5),
              )
            : null,
        child: TextView(
          text: translate(title),
          colorText: isSelect ? AppColor.txtColor2 : AppColor.txtColor4,
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          sizeText: 16,
          weightText: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _topView() {
    return ToolBarApp(
      backIcon: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      actionIcon: const Icon(Icons.filter_alt_outlined),
      title: translate('Messages'),
    );
  }

  Widget _getItem(int index) {
    if (_selected == 3) {
      return UserMessageIetm(
        lastMsg: 'أن الذين كفروا سواء عليهم',
        userImage: AppImages.duserImage,
        userName: 'Mohamed Ahmed',
        lastDate: '9:30 15 Nov',
      );
    } else if (_selected == 0) {
      return GeneralMessageItem(
        boxMessageItem: BoxMessageItem(
          isActive: ((index % 3) == 0),
          ayah: 'أن الذين كفروا سواء عليهم',
          ayahInfo: 'Juz-1  6-Ayah البقرة',
          userImage: AppImages.duserImage,
          userName: 'Mohamed Ahmed',
          dateStr: '9:30 15 Nov',
          color: AppColor.transparent,
        ),
        progressStream: progressStream,
      );
    } else {
      return BoxMessageItem(
        isActive: ((index % 3) == 0),
        ayah: 'أن الذين كفروا سواء عليهم',
        ayahInfo: 'Juz-1  6-Ayah البقرة',
        userImage: AppImages.duserImage,
        userName: 'Mohamed Ahmed',
        dateStr: '9:30 15 Nov',
      );
    }
  }
}
