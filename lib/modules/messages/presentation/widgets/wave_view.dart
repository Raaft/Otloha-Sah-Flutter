import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/constant/constants.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/lib_edit/wave/just_waveform.dart';
import 'package:rxdart/rxdart.dart';

class WaveViewPlayAudio extends StatefulWidget {
  const WaveViewPlayAudio({
    Key? key,
    required this.progressStream,
    required this.trggelPlay,
    required this.isPlay,
  }) : super(key: key);

  final BehaviorSubject<WaveformProgress> progressStream;

  final Function() trggelPlay;

  final bool isPlay;
  @override
  State<WaveViewPlayAudio> createState() => _WaveViewPlayAudioState();
}

class _WaveViewPlayAudioState extends State<WaveViewPlayAudio> {
  Duration position = const Duration();
  AudioPlayer? advancedPlayer;
  Waveform? waveForm;

  AudioCache? audioCache;

  bool _isPlay = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      initPlayer();
    });
  }

  @override
  void didUpdateWidget(WaveViewPlayAudio oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      _isPlay = widget.isPlay;
      if (!_isPlay) {
        advancedPlayer!.pause();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform(
          alignment: Alignment.center,
          transform: isEn ? Matrix4.rotationY(0) : Matrix4.rotationY(pi),
          child: GestureDetector(
            onTap: () {
              _playPause();
            },
            child: Icon(
              _isPlay ? Icons.pause : Icons.play_arrow_outlined,
              size: 40,
              color: AppColor.iconColor2,
            ),
          ),
        ),
        Expanded(
          child: _getWave(context),
        ),
      ],
    );
  }

  Container _getWave(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(4.0),
      child: Container(
        height: 40.0,
        padding: const EdgeInsets.all(2),
        width: MediaQuery.of(context).size.width * 65,
        child: StreamBuilder<WaveformProgress>(
          stream: widget.progressStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
              );
            }
            final progress = snapshot.data?.progress ?? 0.0;
            final waveform = snapshot.data?.waveform;
            if (waveform == null) {
              return Center(
                child: LinearProgressIndicator(
                  value: progress,
                ),
              );
            }

            waveForm = waveform;
            return _audioWave(waveform, position);
          },
        ),
      ),
    );
  }

  void _playPause() {
    if (!_isPlay) {
      widget.trggelPlay();
      startNewRoute();
      setState(() {
        _isPlay = true;
      });
    } else {
      advancedPlayer!.pause();
      setState(() {
        _isPlay = false;
      });
    }
  }

  void initPlayer() {
    advancedPlayer = AudioPlayer();
    audioCache =
        AudioCache(fixedPlayer: advancedPlayer, prefix: 'assets/audio/');

    advancedPlayer!.onPlayerStateChanged.listen((event) {
      setState(() {
        if (event == PlayerState.COMPLETED) {
          _isPlay = false;
        }
      });
    });

    advancedPlayer!.onAudioPositionChanged.listen((Duration current) {
      if (position.inSeconds < current.inSeconds) {
        setState(() {
          position = current;
        });
      }
    });
  }

  Future<void> playSound(String path) async {
    await audioCache!.play(path);
  }

  void startNewRoute() async {
    await playSound('waveform.mp3');
  }

  Widget _audioWave(Waveform waveform, Duration? position) {
    print('position _audioWave ' + position.toString());
    return AudioWaveformWidget(
      waveform: waveform,
      start: Duration.zero,
      current: position ?? Duration.zero,
      strokeWidth: 2,
      duration: Duration(seconds: waveform.duration.inSeconds),
      waveColor: AppColor.waveColor,
      pixelsPerStep: 4,
    );
  }
}

class AudioWaveformWidget extends StatelessWidget {
  final Color waveColor;
  final double scale;
  final double strokeWidth;
  final double pixelsPerStep;
  final Waveform waveform;
  final Duration start;
  final Duration current;
  final Duration duration;

  const AudioWaveformWidget({
    Key? key,
    required this.waveform,
    required this.start,
    required this.duration,
    required this.current,
    this.waveColor = Colors.blue,
    this.scale = 1.0,
    this.strokeWidth = 5.0,
    this.pixelsPerStep = 8.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('position build ' + current.toString());
    return ClipRect(
      child: CustomPaint(
        painter: AudioWaveformPainter(
          waveColor: waveColor,
          waveform: waveform,
          start: start,
          duration: duration,
          current: current,
          scale: scale,
          strokeWidth: strokeWidth,
          pixelsPerStep: pixelsPerStep,
        ),
      ),
    );
  }
}

class AudioWaveformPainter extends CustomPainter {
  final double scale;
  final double strokeWidth;
  final double pixelsPerStep;
  final Paint wavePaint;
  final Waveform waveform;
  final Duration start;
  final Duration current;
  final Duration duration;
  final Color waveColor;

  AudioWaveformPainter({
    required this.waveform,
    required this.start,
    required this.duration,
    required this.current,
    this.waveColor = Colors.blue,
    this.scale = 1.0,
    this.strokeWidth = 5.0,
    this.pixelsPerStep = 8.0,
  }) : wavePaint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round
          ..color = waveColor;

  @override
  void paint(Canvas canvas, Size size) {
    if (duration == Duration.zero) return;

    print('position paint ' + current.toString());

    double width = size.width;
    double height = size.height;

    final waveformPixelsPerWindow = waveform.positionToPixel(duration).toInt();
    final waveformPixelsPerDevicePixel = waveformPixelsPerWindow / width;
    final waveformPixelsPerStep = waveformPixelsPerDevicePixel * pixelsPerStep;
    final sampleOffset = waveform.positionToPixel(start);
    final samplecurrent = waveform.positionToPixel(current);

    Paint wavePaint2 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    wavePaint2.color = AppColor.waveColor2;

    final sampleStart = -sampleOffset % waveformPixelsPerStep;

    for (var i = sampleStart.toDouble();
        i <= waveformPixelsPerWindow + 1.0;
        i += waveformPixelsPerStep) {
      final sampleIdx = (sampleOffset + i).toInt();
      final x = i / waveformPixelsPerDevicePixel;
      final minY = normalise(waveform.getPixelMin(sampleIdx), height);
      final maxY = normalise(waveform.getPixelMax(sampleIdx), height);

      canvas.drawLine(
        Offset(x + strokeWidth / 2, max(strokeWidth * 0.75, minY)),
        Offset(x + strokeWidth / 2, min(height - strokeWidth * 0.75, maxY)),
        (i > (waveformPixelsPerWindow + 1 - samplecurrent))
            ? wavePaint2
            : wavePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant AudioWaveformPainter oldDelegate) {
    return true;
  }

  double normalise(int s, double height) {
    if (waveform.flags == 0) {
      final y = 32768 + (scale * s).clamp(-32768.0, 32767.0).toDouble();
      return height - 1 - y * height / 65536;
    } else {
      final y = 128 + (scale * s).clamp(-128.0, 127.0).toDouble();
      return height - 1 - y * height / 256;
    }
  }
}
