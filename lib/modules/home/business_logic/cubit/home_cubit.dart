import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
<<<<<<< HEAD
=======

import 'package:flutter_base/modules/home/business_logic/cubit/play_button_state.dart';
>>>>>>> main
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_widget_flutter/quran_widget_flutter.dart';
<<<<<<< HEAD
=======
import 'package:flutter_base/data_source/cache_helper.dart';
import 'package:flutter_base/core/utils/constant/constants.dart';
import 'package:path/path.dart' as p;
>>>>>>> main

import '../../../../data_source/models/database_model/user_recitation.dart';
import '../../../../data_source/remote/recitation_services.dart';


part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
<<<<<<< HEAD
  bool isFloatingMenu = false;
  double opacity = 0.0;
=======
  HomeCubit() : super(HomeInitial()) {
    chapterId = CacheHelper.getData(key: chapterSelectedID) ?? 1;
    chapterName =
        (CacheHelper.getData(key: chapterSelectedName) as String?) ?? 'الفاتحة';
    // bookId = CacheHelper.getData(key: bookSelectedId) ?? 1;
    //narrationId = CacheHelper.getData(key: narrationSelectedId) ?? 1;
  }

  static HomeCubit get(context) => BlocProvider.of<HomeCubit>(context);
  bool checkVersesValue = false;
  List<Verse> selectedVerses = [];

  setSelectedVerses(List<Verse> verses) {
    selectedVerses = verses;
    _playlist.clear();
    List<AudioSource> audios = [];

    if (selectedVerses.isEmpty) {
      for (var verse in recitationVerses!) {
        audios.add(AudioSource.uri(Uri.parse('$prefix${verse.record}')));
      }
    } else {
      for (var verse in selectedVerses) {
        String? record = recitationVerses!
            .firstWhere((element) => verse.verseNumber == element.verseNumber)
            .record;
        audios.add(AudioSource.uri(Uri.parse('$prefix$record')));
      }
    }

    _playlist = ConcatenatingAudioSource(children: audios);
  }

  List<Verse> get getSelectedVerses => selectedVerses;

  isVerSelected(bool? verses) {
    if (verses == null || verses == false) {
      checkVersesValue = false;
      emit(CheckIsVerseEmptyState());
>>>>>>> main

  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of<HomeCubit>(context);

  changeIndex(int? index) {
    debugPrint('index $index');
    emit(HomeChangeIndex(index ?? 0));
  }

  PageType pageType = PageType.quran;

  Future<void> changePluginPage({required PageType page}) async {
    print('page type = $page');
    pageType = page;
    emit(ChangePageState());
  }

  changeIsOnTruePressed() {
    isFloatingMenu = false;

    emit(ChangePageFalseState());
  }

  changeTrueFloating() {
    isFloatingMenu = true;
    emit(IsFloatingTrueMenuState());
  }

  changeIsOnFalsePressed() {
    emit(ChangePageFalseState());
  }

<<<<<<< HEAD
  changeOpacity(double myOpacity) {
    opacity = myOpacity;
    emit(ChangeOpacityState());
=======
  void onPreviousSongButtonPressed() {
    audioPlayer.seekToPrevious();
    emit(BackToPreviousVerse());
  }

  void onNextSongButtonPressed() {
    audioPlayer.seekToNext();
    emit(GoToNextVerse());
  }

  int recitationId = 0;

  saveRecitation() async {
    // String customPath = '/File_';
    io.Directory appDocDirectory;

    if (io.Platform.isIOS) {
      appDocDirectory = await getApplicationDocumentsDirectory();
    } else {
      appDocDirectory = (await getExternalStorageDirectory())!;
    }

    final waveFile = File(p.join(
        appDocDirectory.path, '${DateTime.now().microsecondsSinceEpoch}.wave'));

    await _initWave(current!.path!, waveFile);

    List<int> recordedVersesId = [];
    for (var verse in selectedVerses) {
      recordedVersesId.add(verse.id!);
    }
    var userRecitation = UserRecitation(
      narrationId: narrationId,
      record: current!.path ?? '',
      name: getName(),
      versesID: recordedVersesId,
      wavePath: waveFile.path,
    );

    var user = await UserRecitationApi()
        .saveUserReciataion(userRecitation: userRecitation);

    recitationId = user!.id!;
    return recitationId;
  }

  void addSelected(Map<int, List<int>>? values) {
    selectedIndex = values;
  }

  final BehaviorSubject<WaveformProgress> progressStream =
      BehaviorSubject<WaveformProgress>();

  Future<void> _initWave(String path, File waveFile) async {
    final audioFile = io.File(path);
    final progressStream = JustWaveform.extract(
      audioInFile: audioFile,
      waveOutFile: waveFile,
      zoom: const WaveformZoom.pixelsPerSecond(100),
    );
    print(progressStream);
    // await JustWaveform.parse(waveFile);
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
>>>>>>> main
  }
}
