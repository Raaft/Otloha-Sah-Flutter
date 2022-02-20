import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/core/utils/constant/utils.dart';
import 'package:flutter_base/core/utils/res/images_app.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/tool_bar_app.dart';
import 'package:flutter_base/lib_edit/wave/just_waveform.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/box_message_item.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/general_message_item.dart';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:io';

class RecitationsPage extends StatefulWidget {
  const RecitationsPage({Key? key}) : super(key: key);

  static const routeName = '/recitations';

  @override
  State<RecitationsPage> createState() => _RecitationsPageState();
}

class _RecitationsPageState extends State<RecitationsPage> {
  int _selectedPlay = -1;
  final BehaviorSubject<WaveformProgress> progressStream =
      BehaviorSubject<WaveformProgress>();

  final BehaviorSubject<WaveformProgress> streamWave =
      BehaviorSubject<WaveformProgress>();

  late Waveform waveform;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, _init);
  }

  Future<void> _init() async {
    final audioFile =
        File(p.join((await getTemporaryDirectory()).path, 'waveform.mp3'));
    final waveFile2 =
        File(p.join((await getTemporaryDirectory()).path, 'waveform.wave'));
    try {
      await audioFile.writeAsBytes(
          (await rootBundle.load('assets/audio/waveform.mp3'))
              .buffer
              .asUint8List());

      await waveFile2.writeAsBytes(
          (await rootBundle.load('assets/audio/waveform.wave'))
              .buffer
              .asUint8List());
      final waveFile =
          File(p.join((await getTemporaryDirectory()).path, 'waveform.wave'));

      final Stream<WaveformProgress> progressStream2 =
          JustWaveform.extract(audioInFile: audioFile, waveOutFile: waveFile);
      progressStream2.listen(progressStream.add,
          onError: progressStream.addError);

      waveform = await JustWaveform.parse(waveFile2);

      //    JustWaveform.parse(waveFile);

      streamWave.add(WaveformProgress(1, waveform));
    } catch (e) {
      debugPrint('Eror audio' + e.toString());
      progressStream.addError(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          _topView(),
          _viewItems(),
        ],
      )),
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

  Widget _topView() {
    return ToolBarApp(
      backIcon: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      actionIcon: const Icon(Icons.search),
      title: translate('Recitations'),
    );
  }

  Widget _getItem(index) {
    return GeneralMessageItem(
      boxMessageItem: BoxMessageItem(
        isActive: (index % 2 != 0),
        ayah: 'أن الذين كفروا سواء عليهم',
        ayahInfo: 'Juz-1  6-Ayah البقرة',
        userImage: AppImages.duserImage,
        userName: 'Mohamed Ahmed',
        dateStr: '9:30 15 Nov',
        color: AppColor.transparent,
      ),
      progressStream: streamWave,
      likeCount: 20,
      isLike: (index % 2 == 0),
      trggelPlay: () {
        _selectedPlay = index;
      },
      isPlay: index == _selectedPlay,
    );
  }
}
