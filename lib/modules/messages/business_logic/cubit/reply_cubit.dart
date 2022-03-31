import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:file/local.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder2/flutter_audio_recorder2.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'reply_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;

import '../../../../data_source/models/message_model/error_type.dart';
import '../../../../data_source/models/message_model/reply_request.dart';
import '../../../../data_source/remote/messages_service.dart';

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
  String? filePathWave;
  String? ayahText;
  ErrorType? errorType;

  String? text;
  bool viewMessage = false;

  setText(String str) {
    text = str;
    print(text);
    emit(DataChange());
  }

  setViewMessage(bool b) {
    print(b);
    viewMessage = b;
    emit(DataChange());
  }

  saveRelpy(int recitationId, int msgId, int? parentId,
      {ErrorType? errorType}) async {
    this.errorType = errorType;
    String comment = messageController.text;
    if (comment.isNotEmpty || (filePath != null && filePath!.isNotEmpty)) {
      ReplyRequest replyRequest = ReplyRequest(
        recitationId: recitationId,
        messageId: msgId,
        parentId: parentId,
        errorType: (errorType != null) ? errorType.key : null,
        record: filePath,
        comment: messageController.text,
        text: text,
        wave: filePathWave,
        /*  positionFrom:
            (ayahText != null && text != null) ? ayahText!.indexOf(text[0]) : 0,
        positionTo: (ayahText != null && text != null)
            ? ayahText!.indexOf(text[text.length - 1])
            : 0,*/
      );

      Response? response = await GetMessages().replyMessages(replyRequest);

      print('response ' + response.toString());
      if (response != null &&
          response.statusCode! <= 299 &&
          response.statusCode! >= 200) {
        messageController.clear();
        emit(SavedState());
      } else {
        emit(SavedErrorState());
      }
    } else {
      emit(SavedErrorState());
    }
  }

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

        filePathWave = appDocDirectory.path +
            customPath +
            DateTime.now().millisecondsSinceEpoch.toString() +
            'wave.wave';

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

    emit(StartRecordingState(time: '00:00'));
    await _recorder!.start();
    var recording = await _recorder!.current(channel: 0);

    current = recording;

    const tick = Duration(milliseconds: 500);
    Timer.periodic(tick, (Timer t) async {
      if (_currentStatus == RecordingStatus.Stopped) {
        t.cancel();
      }

      var current = await _recorder!.current(channel: 0);

      this.current = current;
      _currentStatus = this.current!.status!;

      emit(
        StartRecordingState(
          time:
              '${current!.duration!.inMinutes.remainder(60)}:${current.duration!.inSeconds.remainder(60)}',
        ),
      );
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

      // await _initWave(filePath!, filePathWave!);
      emit(EndRecordingState());
    } catch (e) {
      print(e);
    }
  }

  // final BehaviorSubject<WaveformProgress> progressStream =
  //     BehaviorSubject<WaveformProgress>();

  // Future<void> _initWave(String path, String wavePath) async {
  //   final audioFile = io.File(path);
  //   try {
  //     final waveFile = io.File(wavePath);
  //
  //     JustWaveform.extract(audioInFile: audioFile, waveOutFile: waveFile)
  //         .listen(progressStream.add, onError: progressStream.addError);
  //
  //     //    JustWaveform.parse(waveFile);
  //   } catch (e) {
  //     debugPrint('Eror audio' + e.toString());
  //     progressStream.addError(e);
  //   }
  // }

  Future delete() async {
    File file = File(current!.path!);
    file.delete();
    emit(DeleteRecordState());
  }

  void onPlayAudio() async {
    AudioPlayer audioPlayer = AudioPlayer();
    await audioPlayer.play(current!.path!, isLocal: true);
  }

  void setErrorType(ErrorType? errorType) {
    this.errorType = errorType;
    emit(ReplyStateDefult());
  }

  void setAyah(String ayah) {
    ayahText = ayah;
    emit(ReplyStateDefult());
  }
}
