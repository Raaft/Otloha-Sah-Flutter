part of 'quranplayer_cubit.dart';

abstract class QuranPlayerState {
  const QuranPlayerState();
}

class QuranPlayerInitial extends QuranPlayerState {}

class BackToPreviousVerse extends QuranPlayerState {}

class GoToNextVerse extends QuranPlayerState {}

class PauseVersesState extends QuranPlayerState {}

class PlayVersesState extends QuranPlayerState {}
