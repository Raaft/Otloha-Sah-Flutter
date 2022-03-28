import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base/core/data/chash_helper.dart';
import 'package:flutter_base/core/utils/constant/constants.dart';
import 'package:flutter_base/modules/data/model/page_marked.dart';
import 'package:flutter_base/modules/data/model/verse_like.dart';
import 'package:flutter_base/modules/data/repository/database_repository.dart';
import 'package:flutter_base/modules/home/business_logic/cubit/play_button_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran_widget_flutter/model/chapter.dart' as chapter;
import 'package:quran_widget_flutter/model/page.dart' as page_obj;
import 'package:quran_widget_flutter/model/verse.dart';
import 'package:quran_widget_flutter/quran_widget_flutter.dart';

part 'quran_state.dart';

class QuranViewCubit extends Cubit<QuranViewState> {
  QuranViewCubit() : super(QuranViewInitial()) {
    chapterId = CacheHelper.getData(key: chapterSelectedID) ?? 1;
    chapterName =
        (CacheHelper.getData(key: chapterSelectedName) as String?) ?? 'الفاتحة';
  }

  static QuranViewCubit get(context) =>
      BlocProvider.of<QuranViewCubit>(context);

  List<Verse> selectedVerses = [];
  bool checkVersesValue = false;

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
    await DataSource.instance
        .fetchChapterById(CacheHelper.getData(key: chapterSelectedID)!)
        .then((value) {
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
  bool isSelectedVerse = false;
  bool isPlaying = false;
  bool playPause = false;

  int lastPlayedVerseNumber = 1;
  bool isRecitationVersesFetched = false;
  bool isPlayerStarted = false;
  bool isVerseCompleted = true;
  List<RecitationVerses>? recitationVerses = [];
  double opacity = 0.0;

  AudioPlayer audioPlayer = AudioPlayer();
  ButtonState buttonState = ButtonState.paused;

  final currentSongTitleNotifier = ValueNotifier<String>('');
  final playlistNotifier = ValueNotifier<List<String>>([]);
  final isFirstSongNotifier = ValueNotifier<bool>(true);
  final isLastSongNotifier = ValueNotifier<bool>(true);
  final playButtonNotifier = PlayButtonNotifier();

  late ConcatenatingAudioSource _playlist;

  String prefix = 'http://165.232.114.22';
  Future<void> _setInitialPlaylist(List<String?> uris) async {
    List<AudioSource> audios = [];
    for (String? uri in uris) {
      audios.add(AudioSource.uri(Uri.parse('$prefix$uri')));
    }

    _playlist = ConcatenatingAudioSource(children: audios);
    await audioPlayer.setAudioSource(_playlist);
  }

  initRecitationVerses() async {
    if (!isRecitationVersesFetched) {
      recitationVerses = await DataSource.instance
          .fetchRecitationsVersesChapterList(
              chapterId: chapterId, recitationId: recitationId);
      isRecitationVersesFetched = true;
    }
    List<String?> urls = [];
    for (var verse in recitationVerses!) {
      urls.add(verse.record);
    }
    await _setInitialPlaylist(urls);
  }

  playVerses() async {
    print('play');
    emit(PlayVersesState());
    audioPlayer.play().whenComplete(() {
      emit(PauseVersesState());
    });
  }

  pausePlayer() async {
    print('pause');
    await audioPlayer.pause();
    playPause = false;
    isVerseCompleted = false;
    emit(PauseVersesState());
  }

  changeIsPlaying() {
    isOnPressed = false;
    isSelectedVerse = false;
    isRecorded = false;
    isRecordedFile = false;
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

    emit(IsFloatTrueMenuState());
  }

  changeOpacity(double myOpacity) {
    opacity = myOpacity;
    emit(ChangeOpacityState());
  }

  changeFalseFloating() {
    isOnPressed = false;
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

    emit(IsOnPressFalseState());
  }

  changeIsOnFalsePressed() {
    isOnPressed = false;
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

  void onPlayAudio() async {
    // AudioPlayer audioPlayer = AudioPlayer();
    await audioPlayer.play();
  }

  void onPreviousSongButtonPressed() {
    audioPlayer.seekToPrevious();
    emit(BackToPreviousVerse());
  }

  void onNextSongButtonPressed() {
    audioPlayer.seekToNext();
    emit(GoToNextVerse());
  }

  int recitationId = 0;

  void addSelected(Map<int, List<int>>? values) {
    selectedIndex = values;
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

  void saveLiked() {
    changeIsLiked();
    DatabaseRepository().insertVerseLiked(
      VerseLiked(
        idFromVerse: selectedVerses[0].id,
        pageNumber: page!.pageNumber ?? 0,
        textFristVerse: getName(),
        idToVerse: selectedVerses[selectedVerses.length - 1].id,
        idPage: page!.id ?? 0,
      ),
    );
  }

  void addBookMark() {
    changeIsBookmarked();
    getChapterName(chapterId: page!.chapters![0].chapterId).then((value) {
      DatabaseRepository().insertPageMarked(PageMarked(
        idBook: page!.bookId,
        pageNumber: page!.id,
        textVerse: myChapter!.name,
        idPage: page!.id,
      ));
    });
  }
}
