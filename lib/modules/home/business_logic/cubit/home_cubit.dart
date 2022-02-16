import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io' as io;

import 'package:audioplayers/audioplayers.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder2/flutter_audio_recorder2.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  changeIndex(int? index) {
    emit(HomeInitial());
    debugPrint('index $index');
    emit(HomeChangeIndex(index ?? 0));
  }

  bool isLiked = false;
  bool isBookmarked = false;
  bool isOnPressed = false;
  bool isRecorded = false;
  bool isRecordedFile = false;

  changeIsLiked() {
    if (isLiked == false) {
      isLiked = true;
      emit(IsLikedTrueState());
    } else {
      isLiked = false;
      emit(IsLikedFalseState());
    }
  }

  changeIsBookmarked() {
    if (isBookmarked == false) {
      isBookmarked = true;
      emit(IsBookMarkTrueState());
    } else {
      isBookmarked = false;
      emit(IsBookMarkFalseState());
    }
  }

  changeIsOnTruePressed() {
    isOnPressed = true;
    isRecorded = false;
    isRecordedFile = false;

    emit(IsOnPressFalseState());
  }

  changeIsOnFalsePressed() {
    isOnPressed = false;

    emit(IsOnPressTrueState());
  }

  changeIsRecorded() {
    isOnPressed = false;
    isRecordedFile = false;
    isRecorded = true;
    emit(IsRecordedState());
  }

  changeIsRecordedFile() {
    isOnPressed = false;
    isRecorded = false;
    isRecordedFile = true;
    emit(IsRecordedFileState());
  }

  /// to record

  FlutterAudioRecorder2? _recorder;
  Recording? current;
  RecordingStatus _currentStatus = RecordingStatus.Unset;
  LocalFileSystem? localFileSystem;
  Stream<Duration> duration = const Stream.empty();

  Future init() async {
    try {
      bool hasPermission = await FlutterAudioRecorder2.hasPermissions ?? false;

      if (hasPermission) {
        String customPath = '/flutter_audio_recorder_';
        io.Directory appDocDirectory;

        if (io.Platform.isIOS) {
          appDocDirectory = await getApplicationDocumentsDirectory();
        } else {
          appDocDirectory = (await getExternalStorageDirectory())!;
        }

        customPath = appDocDirectory.path +
            customPath +
            DateTime.now().millisecondsSinceEpoch.toString();

        _recorder =
            FlutterAudioRecorder2(customPath, audioFormat: AudioFormat.WAV);

        await _recorder!.initialized;

        var current = await _recorder!.current(channel: 0);
        print(current);

        this.current = current;
        _currentStatus = current!.status!;
        print(_currentStatus);
      } else {
        print('You must accept permissions');
      }
    } catch (e) {
      print(e);
    }
  }

  Future start() async {
    try {
      await _recorder!.start();
      var recording = await _recorder!.current(channel: 0);

      current = recording;

      const tick = Duration(milliseconds: 50);
      Timer.periodic(tick, (Timer t) async {
        if (_currentStatus == RecordingStatus.Stopped) {
          t.cancel();
        }

        var current = await _recorder!.current(channel: 0);

        this.current = current;
        _currentStatus = this.current!.status!;
      });
    } catch (e) {
      print(e);
    }
  }

  Stream<Duration> getDuration() async* {
    const tick = Duration(milliseconds: 500);
    Timer.periodic(tick, (Timer t) async* {
      if (_currentStatus == RecordingStatus.Stopped) {
        t.cancel();
      }
      yield current!.duration;
    });
  }

  Future resume() async {
    await _recorder!.resume();
  }

  Future pause() async {
    await _recorder!.pause();
  }

  Future stop() async {
    var result = await _recorder!.stop();
    print('Stop recording: ${result!.path}');
    print('Stop recording: ${result.duration}');
    File file = localFileSystem!.file(result.path);
    print('File length: ${await file.length()}');

    current = result;
    _currentStatus = current!.status!;
  }

  void onPlayAudio() async {
    AudioPlayer audioPlayer = AudioPlayer();
    await audioPlayer.play(current!.path!, isLocal: true);
  }

/*
  getHasRecord() async {
    bool hasPermission = await RecordPlatform.instance.hasPermission();
    emit(RecordHasPermission(hasPermission: hasPermission));
  }

  getPlayRecord() async {
    var root = await getTemporaryDirectory();
    await RecordPlatform.instance.start(
      path: root.path + '/record.m4a',
      encoder: AudioEncoder.AAC,
    );
    var isPlay = await RecordPlatform.instance.isRecording();

    emit(RecordIsRecord(isRecord: isPlay));
  }*/

}
