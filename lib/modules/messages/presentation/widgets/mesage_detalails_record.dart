
import 'package:flutter/material.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/wave_view.dart';

class MessageDetailsRecord extends StatefulWidget {
  const MessageDetailsRecord({Key? key}) : super(key: key);

  @override
  State<MessageDetailsRecord> createState() => _MessageDetailsRecordState();
}

class _MessageDetailsRecordState extends State<MessageDetailsRecord> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: WaveViewPlayAudio(
          isPlay: false,
          recordPath: '',
          wavePath: '',
          trggelPlay: () {},
        ));
  }
}
