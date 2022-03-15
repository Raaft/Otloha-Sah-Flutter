import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'package:flutter_base/core/utils/themes/color.dart';
import 'package:flutter_base/lib_edit/wave/just_waveform.dart';

class WaveView extends StatelessWidget {
  WaveView({
    Key? key,
    required this.progressStream,
    this.position = const Duration(),
    this.waveForm,
  }) : super(key: key);
  Duration position;

  final BehaviorSubject<WaveformProgress> progressStream;

  Waveform? waveForm;
  @override
  Widget build(BuildContext context) {
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
