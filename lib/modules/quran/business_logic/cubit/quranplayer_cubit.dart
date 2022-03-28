import 'package:flutter_base/modules/home/business_logic/cubit/play_button_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

part 'quranplayer_state.dart';

class QuranPlayerCubit extends Cubit<QuranPlayerState> {
  QuranPlayerCubit() : super(QuranPlayerInitial());
  static QuranPlayerCubit get(context) =>
      BlocProvider.of<QuranPlayerCubit>(context);

  final playButtonNotifier = PlayButtonNotifier();

  AudioPlayer audioPlayer = AudioPlayer();
  ButtonState buttonState = ButtonState.paused;

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
    emit(PauseVersesState());
  }
}
