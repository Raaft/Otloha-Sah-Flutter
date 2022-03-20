import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';

import 'package:file/local.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder2/flutter_audio_recorder2.dart';
import 'package:flutter_base/modules/messages/business_logic/cubit/reply_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;

class ReplyCubit extends Cubit<ReplyState> {
  ReplyCubit() : super(InitialReplyState());
  static ReplyCubit get(context) => BlocProvider.of(context);

  TextEditingController messageController = TextEditingController();

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
    await init();
    print('asd');

    emit(StartRecordingState());
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

    return null;
  }

  Future stop() async {
    try {
      var result = await _recorder!.stop();
      print('Stop recording: ${result!.path}');
      print('Stop recording: ${result.duration}');

      current = result;
      _currentStatus = current!.status!;

      emit(EndRecordingState());
    } catch (e) {
      print(e);
    }
  }

  Future delete() async {
    File file = File(current!.path!);
    file.delete();
    emit(DeleteRecordState());
  }

  void onPlayAudio() async {
    AudioPlayer audioPlayer = AudioPlayer();
    await audioPlayer.play(current!.path!, isLocal: true);
  }
}
