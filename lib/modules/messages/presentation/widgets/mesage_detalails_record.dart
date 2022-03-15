import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/wave_view.dart';
import 'package:rxdart/rxdart.dart';

import 'package:flutter_base/modules/messages/business_logic/cubit/messagetap_cubit.dart';

import 'package:flutter/services.dart';
import 'package:flutter_base/lib_edit/wave/just_waveform.dart';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class MessageDetailsRecord extends StatefulWidget {
  const MessageDetailsRecord({Key? key}) : super(key: key);

  @override
  State<MessageDetailsRecord> createState() => _MessageDetailsRecordState();
}

class _MessageDetailsRecordState extends State<MessageDetailsRecord> {
  final BehaviorSubject<WaveformProgress> streamWave =
      BehaviorSubject<WaveformProgress>();

  late Waveform waveform;

  late MessageTapCubit? cubit;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, _init);
  }

  Future<void> _init() async {
    final waveFile2 =
        File(p.join((await getTemporaryDirectory()).path, 'waveform.wave'));
    try {
      await waveFile2.writeAsBytes(
          (await rootBundle.load('assets/audio/waveform.wave'))
              .buffer
              .asUint8List());

      waveform = await JustWaveform.parse(waveFile2);

      //    JustWaveform.parse(waveFile);

      streamWave.add(WaveformProgress(1, waveform));
    } catch (e) {
      debugPrint('Eror audio' + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
        child: WaveViewPlayAudio(
          isPlay: false,
          progressStream: streamWave,
          trggelPlay: () {},
        ));
  }
}
