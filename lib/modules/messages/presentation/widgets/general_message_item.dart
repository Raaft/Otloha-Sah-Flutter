import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_base/core/utils/res/icons_app.dart';
import 'package:flutter_base/core/utils/res/images_app.dart';
import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/core/widgets/text_view.dart';
import 'package:flutter_base/modules/messages/presentation/widgets/box_message_item.dart';
import 'package:just_waveform/just_waveform.dart';
import 'package:rxdart/rxdart.dart';

class GeneralMessageItem extends StatelessWidget {
  const GeneralMessageItem(
      {Key? key, required this.boxMessageItem, required this.progressStream})
      : super(key: key);

  final BoxMessageItem boxMessageItem;

  final BehaviorSubject<WaveformProgress> progressStream;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: boxMessageItem.isActive
            ? AppColor.selectColor1
            : AppColor.transparent,
      ),
      child: Column(
        children: [
          boxMessageItem,
          Row(
            children: [
              Icon(
                Icons.play_arrow_outlined,
                size: 40,
                color: AppColor.iconColor2,
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
                    Image.asset(
                      AppIcons.likeIcon,
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
                    const SizedBox(width: 8),
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
                    const SizedBox(width: 8),
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
                SizedBox(
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
                              colors: [AppColor.gradient6, AppColor.gradient3],
                            ),
                          ),
                          child: TextView(
                            text: '20',
                            colorText: AppColor.txtColor2,
                            sizeText: 10,
                          ),
                        ),
                      ),
                    ],
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
          stream: progressStream,
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
                child: Text(
                  '${(100 * progress).toInt()}%',
                  style: Theme.of(context).textTheme.headline6,
                ),
              );
            }
            return AudioWaveformWidget(
              waveform: waveform,
              start: Duration.zero,
              strokeWidth: 2,
              duration: waveform.duration,
              waveColor: AppColor.waveColor,
              pixelsPerStep: 4,
            );
          },
        ),
      ),
    );
  }
}

class AudioWaveformWidget extends StatefulWidget {
  final Color waveColor;
  final double scale;
  final double strokeWidth;
  final double pixelsPerStep;
  final Waveform waveform;
  final Duration start;
  final Duration duration;

  const AudioWaveformWidget({
    Key? key,
    required this.waveform,
    required this.start,
    required this.duration,
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
  final Duration duration;

  AudioWaveformPainter({
    required this.waveform,
    required this.start,
    required this.duration,
    Color waveColor = Colors.blue,
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
        wavePaint,
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
