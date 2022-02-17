import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/constant/constants.dart';
import 'package:flutter_base/core/utils/res/icons_app.dart';
import 'package:flutter_base/core/utils/res/images_app.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/text_view.dart';
import 'package:flutter_base/lib_edit/wave/just_waveform.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/box_message_item.dart';
import 'package:rxdart/rxdart.dart';

class GeneralMessageItem extends StatefulWidget {
  const GeneralMessageItem({
    Key? key,
    required this.boxMessageItem,
    required this.progressStream,
    required this.isLike,
    required this.likeCount,
    this.waveForm,
    this.liked,
    this.goLike,
    this.goNote,
    this.goReMraker,
  }) : super(key: key);

  final BoxMessageItem boxMessageItem;

  final BehaviorSubject<WaveformProgress> progressStream;
  final Waveform? waveForm;

  final bool isLike;
  final Function()? liked;
  final Function()? goLike;
  final Function()? goNote;
  final Function()? goReMraker;
  final int likeCount;

  @override
  State<GeneralMessageItem> createState() => _GeneralMessageItemState();
}

class _GeneralMessageItemState extends State<GeneralMessageItem> {
  Duration position = const Duration();

  AudioPlayer? advancedPlayer;
  AudioCache? audioCache;

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  void initPlayer() {
    advancedPlayer = AudioPlayer();
    audioCache =
        AudioCache(fixedPlayer: advancedPlayer, prefix: 'assets/audio/');

    advancedPlayer!.onAudioPositionChanged.listen((Duration current) {
      print('position ' + current.toString());
      setState(() => position = current);
    });
  }

  Future<void> playSound(String path) async {
    await audioCache!.play(path);
    Timer.periodic(const Duration(seconds: 1), (timer) {
      print('object');
      if (_isPlay) {
        timer.cancel();
      }
      setState(() async {
        var time = await advancedPlayer!.getCurrentPosition();
        position = Duration(microseconds: time);
      });
    });
  }

  bool _isPlay = false;

  void startNewRoute() async {
    await playSound('waveform.mp3');
    // more code here
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: widget.boxMessageItem.isActive
            ? AppColor.selectColor1
            : AppColor.transparent,
      ),
      child: Column(
        children: [
          widget.boxMessageItem,
          Row(
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
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      child: Image.asset(
                        widget.isLike ? AppIcons.like2Icon : AppIcons.likeIcon,
                        color: widget.isLike
                            ? AppColor.darkBlue
                            : AppColor.txtColor4d,
                        width: 20,
                        height: 20,
                      ),
                      onTap: widget.liked,
                    ),
                    TextView(
                      text: widget.likeCount.toString(),
                      colorText: AppColor.txtColor4d,
                      sizeText: 20,
                      weightText: FontWeight.bold,
                      action: widget.goLike,
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: widget.goNote,
                      child: Row(
                        children: [
                          Image.asset(
                            AppIcons.bubbleIcon,
                            color: AppColor.iconColor,
                            width: 20,
                            height: 20,
                          ),
                          TextView(
                            text: '20',
                            colorText: AppColor.txtColor4d,
                            sizeText: 20,
                            weightText: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      child: Row(
                        children: [
                          Image.asset(
                            AppIcons.quality2Icon,
                            color: AppColor.iconColor,
                            width: 20,
                            height: 20,
                          ),
                          TextView(
                            text: '20',
                            colorText: AppColor.txtColor4d,
                            sizeText: 20,
                            weightText: FontWeight.bold,
                          ),
                        ],
                      ),
                      onTap: widget.goReMraker,
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: widget.goLike,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * .25,
                    child: Stack(
                      children: [
                        Align(
                          alignment: const Alignment(-1, 0),
                          child: _circalUser(),
                        ),
                        Align(
                          alignment: const Alignment(-.62, 0),
                          child: _circalUser(),
                        ),
                        Align(
                          alignment: const Alignment(-.24, 0),
                          child: _circalUser(),
                        ),
                        Align(
                          alignment: const Alignment(.14, 0),
                          child: _circalUser(),
                        ),
                        Align(
                          alignment: const Alignment(.52, 0),
                          child: _circalUser(),
                        ),
                        Align(
                          alignment: const Alignment(.95, 0),
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                colors: [
                                  AppColor.gradient6,
                                  AppColor.gradient3
                                ],
                              ),
                            ),
                            child: TextView(
                              text: '+9',
                              colorText: AppColor.txtColor2,
                              sizeText: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  SizedBox _circalUser() {
    return SizedBox(
      width: 20,
      height: 20,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(AppImages.duserImage),
      ),
    );
  }

  _getWave(BuildContext context) {
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

            return _audioWave(waveform);
          },
        ),
      ),
    );
  }

  AudioWaveformWidget _audioWave(Waveform waveform) {
    return AudioWaveformWidget(
      waveform: waveform,
      start: Duration.zero,
      current: position,
      strokeWidth: 2,
      duration: Duration(seconds: waveform.duration.inSeconds),
      waveColor: AppColor.waveColor,
      pixelsPerStep: 4,
    );
  }

  @override
  void dispose() {
    super.dispose();
    advancedPlayer!.dispose();
  }

  void _playPause() {
    if (!_isPlay) {
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
}

class AudioWaveformWidget extends StatefulWidget {
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
  _AudioWaveformState createState() => _AudioWaveformState();
}

class _AudioWaveformState extends State<AudioWaveformWidget> {
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: CustomPaint(
        painter: AudioWaveformPainter(
          waveColor: widget.waveColor,
          waveform: widget.waveform,
          start: widget.start,
          duration: widget.duration,
          current: widget.current,
          scale: widget.scale,
          strokeWidth: widget.strokeWidth,
          pixelsPerStep: widget.pixelsPerStep,
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
        (i > (waveformPixelsPerWindow - samplecurrent))
            ? wavePaint2
            : wavePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant AudioWaveformPainter oldDelegate) {
    return false;
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
