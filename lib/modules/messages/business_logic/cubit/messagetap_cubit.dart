import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'messagetap_state.dart';

class MessageTapCubit extends Cubit<MessageTapState> {
  MessageTapCubit() : super(MessageTapInitial());

  changeIndex(int index) {
    emit(MessageTapInitial());
    emit(MessageTapChange(index: index));
  }

  /// play
  Duration position = const Duration();

  AudioPlayer? advancedPlayer;
  AudioCache? audioCache;

  void initPlayer() {
    advancedPlayer = AudioPlayer();
    audioCache =
        AudioCache(fixedPlayer: advancedPlayer, prefix: 'assets/audio/');

    advancedPlayer!.onAudioPositionChanged.listen((Duration current) {
      print('position ' + current.toString());
      position = current;
    });
  }

  Future<void> playSound(String path) async {
    await audioCache!.play(path);
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      print('object');
      if (_isPlay) {
        timer.cancel();
      }
      var time = await advancedPlayer!.getCurrentPosition();
      position = Duration(microseconds: time);
    });
  }

  bool _isPlay = false;

  void startNewRoute() async {
    await playSound('waveform.mp3');
    // more code here
  }
}
