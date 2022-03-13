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
import 'package:quran_widget_flutter/quran_widget_flutter.dart';
import 'package:flutter_base/core/data/chash_helper.dart';
import 'package:flutter_base/core/utils/constant/constants.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial()) {
    chapterId = CacheHelper.getData(key: chapterID) ?? 1;
    chapterN = (CacheHelper.getData(key: chapterName) as String?) ?? 'elfateja';
    // bookId = CacheHelper.getData(key: bookSelectedId) ?? 1;
    //narrationId = CacheHelper.getData(key: narrationSelectedId) ?? 1;
  }

  static HomeCubit get(context) => BlocProvider.of(context);
  bool checkVersesValue = false;

  isVerSelected(bool? verses) {
    if (verses == null || verses == false) {
      checkVersesValue = false;
      emit(CheckIsVerseEmptyState());

      return false;
    } else {
      checkVersesValue = true;

      emit(CheckIsVerseEmptyState());
    }

    emit(DoneCheckIsVerseEmptyState());
  }

  PageType pageType = PageType.quran;

  Future<void> changePluginPage({required PageType page}) async {
    print('page type = $page');
    pageType = page;
    emit(ChangePageState());
  }

  changeIndex(int? index) {
    emit(HomeInitial());
    debugPrint('index $index');
    emit(HomeChangeIndex(index ?? 0));
  }

  int chapterId = 1;
  int bookId = 1;
  int narrationId = 1;
  String? chapterN = 'الفاتحة';
  String juz = 'جزء رقم 1';

  changeChapter(int newChapter) {
    chapterId = newChapter;
    chapterN = (CacheHelper.getData(key: chapterName) as String);
    emit(QuranChangeChapter());
  }

  changeJuz(int newJux) {
    juz = 'جزء رقم ' + newJux.toString();
    emit(QuranChangeChapter());
  }

  bool isLiked = false;
  bool isBookmarked = false;
  bool isOnPressed = false;
  bool isRecorded = false;
  bool isRecordedFile = false;
  bool isFloatingMenu = false;
  bool isSelectedVerse = false;
  bool isPlaying = false;
  bool playPause = true;

  double opacity = 0.0;

  changePlayPause() {
    playPause = !playPause;

    emit(ChangePlayPauseState());
  }

  changeIsPlaying() {
    isOnPressed = false;
    isSelectedVerse = false;
    isRecorded = false;
    isRecordedFile = false;
    isFloatingMenu = false;
    isPlaying = true;
    emit(ChangeIsPlayingState());
  }

  changeIsSelectedVerse() {
    isSelectedVerse = true;

    emit(ChangeIsSelectedVerseState());
  }

  changeTrueFloating() {
    isOnPressed = false;
    isRecorded = false;
    isRecordedFile = false;
    isFloatingMenu = true;

    emit(IsFloatingTrueMenuState());
  }

  changeOpacity(double myOpacity) {
    opacity = myOpacity;
    emit(ChangeOpacityState());
  }

  changeFalseFloating() {
    isOnPressed = false;
    isFloatingMenu = false;

    emit(IsFloatingFalseMenuState());
  }

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
    isSelectedVerse = false;
    isPlaying = false;
    isRecorded = false;
    isRecordedFile = false;
    isFloatingMenu = false;

    emit(IsOnPressFalseState());
  }

  changeIsOnFalsePressed() {
    isOnPressed = false;
    isFloatingMenu = false;
    isPlaying = false;

    emit(IsOnPressTrueState());
  }

  changeIsRecorded() {
    isOnPressed = false;
    isSelectedVerse = false;
    isRecordedFile = false;
    isRecorded = true;
    emit(IsRecordedState());
  }

  changeIsRecordedFile() {
    isOnPressed = false;
    isSelectedVerse = false;

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

  Future<Stream?> start() async {
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
        emit(ChangeDurationState());
        emit(GetDurationState());
      });
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future resume() async {
    await _recorder!.resume();
  }

  Future pause() async {
    await _recorder!.pause();
  }

  Future stop() async {
    try {
      var result = await _recorder!.stop();
      print('Stop recording: ${result!.path}');
      print('Stop recording: ${result.duration}');
      File? file = localFileSystem!.file(result.path);
      print('File length: ${await file.length()}');

      current = result;
      _currentStatus = current!.status!;
    } catch (e) {
      print(e);
    }
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
