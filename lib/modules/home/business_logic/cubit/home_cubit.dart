import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base/modules/data/data_source/remote/data_source/user_recitation_api.dart';
import 'package:flutter_base/modules/data/model/user_recitation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:path_provider/path_provider.dart';
import 'package:quran_widget_flutter/model/chapter.dart' as chapter;
import 'dart:async';
import 'dart:io' as io;
import 'package:quran_widget_flutter/model/page.dart' as page_obj;
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:file/local.dart';
import 'package:flutter_audio_recorder2/flutter_audio_recorder2.dart';
import 'package:quran_widget_flutter/quran_widget_flutter.dart';
import 'package:flutter_base/core/data/chash_helper.dart';
import 'package:flutter_base/core/utils/constant/constants.dart';

import '../../../../lib_edit/wave/just_waveform.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial()) {
    chapterId = CacheHelper.getData(key: chapterSelectedID) ?? 1;
    chapterName =
        (CacheHelper.getData(key: chapterSelectedName) as String?) ?? 'الفاتحة';
    // bookId = CacheHelper.getData(key: bookSelectedId) ?? 1;
    //narrationId = CacheHelper.getData(key: narrationSelectedId) ?? 1;
  }

  static HomeCubit get(context) => BlocProvider.of(context);
  bool checkVersesValue = false;

  bool isLogin = false;

  Future<void> changeIsLogin({required bool isLogin}) async {
    await CacheHelper.saveData(key: 'isLogin', value: this.isLogin);
    var log = await CacheHelper.getData(key: 'isLogin') ?? false;
    isLogin = log;
    emit(ChangeIsLogInStateState());
  }

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
  String? chapterName = 'الفاتحة';
  String juz = '';

  changeChapter(int newChapter) {
    chapterId = newChapter;
    juz = page!.partId.toString();
    chapterName =
        ((CacheHelper.getData(key: chapterSelectedName) ?? '') as String);
    emit(QuranChangeChapter());
  }

  Map<int, List<int>>? selectedIndex = {};
  page_obj.Page? page;

  chapter.Chapter? myChapter;
  Future<void> getChapterName({required int? chapterId}) async {
    emit(GetChapterByIdLoadingState());
    await DataSource.instance.fetchChapterById(chapterId!).then((value) {
      myChapter = value;
      emit(GetChapterByIdSucssState());
    }).catchError((e) {
      print(e);
      emit(GetChapterByIdErrorState());
    });
  }

  changeJuz(int newJux, int newChapter, page_obj.Page page) async {
    this.page = page;
    juz = 'جزء رقم ' + newJux.toString();
    await DataSource.instance.fetchChapterById(newChapter).then((value) {
      if (value != null) {
        chapterId = value.id!;
        chapterName = value.name;
        CacheHelper.saveData(key: chapterSelectedID, value: chapterId);
        CacheHelper.saveData(key: chapterSelectedName, value: chapterName);
      }
    });
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
    AudioPlayer audioPlayer = AudioPlayer();
    playPause = !playPause;
    emit(ChangePlayPauseState());
    print(selectedIndex);
    if (playPause) {
      selectedIndex!.forEach((key, value) {
        for (int i in value) {
          // audioPlayer.play();
        }
      });
    }
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
  String? filePath;

  Future init() async {
    try {
      print('start init');
      bool hasPermission = await FlutterAudioRecorder2.hasPermissions ?? false;

      if (hasPermission) {
        String customPath = '/File_';
        io.Directory appDocDirectory;

        if (io.Platform.isIOS) {
          appDocDirectory = await getApplicationDocumentsDirectory();
        } else {
          appDocDirectory = (await getExternalStorageDirectory())!;
        }

        customPath = appDocDirectory.path +
            customPath +
            DateTime.now().millisecondsSinceEpoch.toString() +
            '.wav';

        filePath = customPath;

        _recorder =
            FlutterAudioRecorder2(customPath, audioFormat: AudioFormat.WAV);

        await _recorder!.initialized;

        var current = await _recorder!.current(channel: 0);
        print(current);

        this.current = current;
        _currentStatus = current!.status!;
        print(_currentStatus);
        print('end init');
      } else {
        print('You must accept permissions');
      }
    } catch (e) {
      print('init Error' + e.toString());
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

  int recitationId = 0;

  saveRecitation() async {
    String customPath = '/File_';
    io.Directory appDocDirectory;

    if (io.Platform.isIOS) {
      appDocDirectory = await getApplicationDocumentsDirectory();
    } else {
      appDocDirectory = (await getExternalStorageDirectory())!;
    }

    var wave = appDocDirectory.path +
        customPath +
        DateTime.now().millisecondsSinceEpoch.toString() +
        '.wave';

    var userRecitation = UserRecitation(
      narrationId: narrationId,
      record: current!.path ?? '',
      name: getName(),
      versesID: selectedIndex![0],
      wavePath: wave,
    );

    await _initWave(userRecitation.record ?? '', userRecitation.wavePath ?? '');

    var user = await UserRecitationApi()
        .saveUserReciataion(userRecitation: userRecitation);
    if (user != null) {
      recitationId = user.id ?? 0;
    }
    print(userRecitation);
  }

  void addSelected(Map<int, List<int>>? values) {
    selectedIndex = values;
  }

  final BehaviorSubject<WaveformProgress> progressStream =
      BehaviorSubject<WaveformProgress>();

  Future<void> _initWave(String path, String wavePath) async {
    final audioFile = io.File(path);
    try {
      final waveFile = io.File(wavePath);

      JustWaveform.extract(audioInFile: audioFile, waveOutFile: waveFile)
          .listen(progressStream.add, onError: progressStream.addError);

      //    JustWaveform.parse(waveFile);
    } catch (e) {
      debugPrint('Eror audio' + e.toString());
      progressStream.addError(e);
    }
  }

  getName() {
    print(page!.verses.toString());
    String? text = '';

    for (var element in page!.verses!) {
      if (element.id == _getVerses()) {
        text = element.text;
        break;
      }
    }

    print('name ' + getFirstWords(text ?? '', 5));

    return getFirstWords(text ?? '', 5);
  }

  int? _getVerses() {
    print('object ${selectedIndex![0]} ${selectedIndex![0]![0]}');
    return selectedIndex![0]![0];
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

  String getFirstWords(String sentence, int wordCounts) {
    try {
      return sentence.split(' ').sublist(0, wordCounts).join(' ');
    } catch (e) {
      return sentence;
    }
  }
}
