import 'package:flutter/material.dart';

import 'wave_view.dart';

class MessageDetailsRecord extends StatelessWidget {
  const MessageDetailsRecord({
    Key? key,
    required this.recordPath,
    required this.wavePath,
    this.isLocal = false,
  }) : super(key: key);

  final String? recordPath;
  final String? wavePath;
  final bool isLocal;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: WaveViewPlayAudio(
          isPlay: false,
          recordPath: recordPath,
          wavePath: wavePath,
          trggelPlay: () {},
          isLocal: isLocal,
        ));
  }
}
