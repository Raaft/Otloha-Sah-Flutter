import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_audio_recorder2/flutter_audio_recorder2.dart';
import '../../../../data_source/models/database_model/user_recitation.dart';
import '../../../../data_source/remote/recitation_services.dart';
import '../../../../lib_edit/wave/just_waveform.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:quran_widget_flutter/model/page.dart' as page_obj;
import 'package:quran_widget_flutter/model/verse.dart';
import 'package:rxdart/rxdart.dart';

part 'recitation_state.dart';

class RecitationAddCubit extends Cubit<RecitationAddState> {
  RecitationAddCubit() : super(RecitationInitial());

  get current => _current;

  static RecitationAddCubit get(context) =>
      BlocProvider.of<RecitationAddCubit>(context);

  /// to record
  FlutterAudioRecorder2? _recorder;
  Recording? _current;
  RecordingStatus _currentStatus = RecordingStatus.Unset;
  AudioPlayer audioPlayer = AudioPlayer();

  final int _narrationId = 1;
  int _recitationId = 1;

  bool checkVersesValue = false;
  List<Verse> selectedVerses = [];
  File? waveFile;

  page_obj.Page? page;

  final BehaviorSubject<WaveformProgress> progressStream =
      BehaviorSubject<WaveformProgress>();

  Future init() async {
    bool hasPermission = await FlutterAudioRecorder2.hasPermissions ?? false;

    if (hasPermission) {
      String customPath = '/FilesGeneratedRecoed';
      Directory appDocDirectory;

      if (Platform.isIOS) {
        appDocDirectory = await getApplicationDocumentsDirectory();
      } else {
        appDocDirectory = (await getApplicationDocumentsDirectory());
      }

      customPath = appDocDirectory.path +
          customPath +
          DateTime.now().millisecondsSinceEpoch.toString() +
          '.wav';

      _recorder =
          FlutterAudioRecorder2(customPath, audioFormat: AudioFormat.WAV);

      await _recorder!.initialized;

      var current = await _recorder!.current(channel: 0);
      print(current);

      _current = current;
      _currentStatus = current!.status!;
      print(_currentStatus);
      print('end init');
    } else {
      print('You must accept permissions');
    }
  }

  void onPlayAudio() async {
    audioPlayer = AudioPlayer();
    await audioPlayer.play(current!.path!, isLocal: true);
  }

  Future<Stream?> start() async {
    try {
      await _recorder!.start();
      var recording = await _recorder!.current(channel: 0);

      _current = recording;

      const tick = Duration(milliseconds: 500);
      Timer.periodic(tick, (Timer t) async {
        if (_currentStatus == RecordingStatus.Stopped) {
          t.cancel();
        }

        var current = await _recorder!.current(channel: 0);

        _current = current;
        _currentStatus = _current!.status!;
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
    var result = await _recorder!.stop();
    _current = result;
    _currentStatus = _current!.status!;
  }

  Future stop() async {
    try {
      var result = await _recorder!.stop();
      print('Stop recording: ${result!.path}');
      print('Stop recording: ${result.duration}');

      _current = result;
      _currentStatus = _current!.status!;
    } catch (e) {
      print(e);
    }
  }

  // _initWave(String audioFile) async {
  //   try {
  //     // await audioFile.writeAsBytes((audioFile).buffer.asUint8List());
  //     waveFile = File(p.join((await getApplicationDocumentsDirectory()).path,
  //         '${DateTime.now().microsecondsSinceEpoch}.wave'));

  //     JustWaveform.extract(audioInFile: File(audioFile), waveOutFile: waveFile!)
  //         .doOnDone(() async {
  //       await waveFile!.create();
  //     });
  //     int i = await waveFile!.length();
  //     print('askcjnakscjnackjnask $i');
  //   } catch (e) {
  //     progressStream.addError(e);
  //   }
  // }

  saveRecitation() async {
    waveFile = File(p.join((await getApplicationDocumentsDirectory()).path,
        '${DateTime.now().microsecondsSinceEpoch}.wave'));

    JustWaveform.extract(
      audioInFile: File(_current!.path!),
      waveOutFile: waveFile!,
      zoom: const WaveformZoom.pixelsPerSecond(100),
    ).listen((event) {}, onDone: () async {
      List<int> recordedVersesId = [];
      for (var verse in selectedVerses) {
        recordedVersesId.add(verse.id!);
      }

      var userRecitation = UserRecitation(
        narrationId: _narrationId,
        record: _current!.path ?? '',
        name: getName(),
        versesID: recordedVersesId,
        wavePath: waveFile!.path,
      );

      var user = await UserRecitationApi()
          .saveUserReciataion(userRecitation: userRecitation);

      _recitationId = user!.id!;
      print('saveRecitation -> ' + userRecitation.toString());
    });
    return _recitationId;
  }

  setSelectedVerses(List<Verse> verses) {
    print('setSelectedVerses ' + verses.toString());
    selectedVerses.addAll(verses);
    emit(state);
  }

  getName() {
    String? text = selectedVerses.first.uthmanicText;

    print('name ' + getFirstWords(text ?? '', 5));

    return getFirstWords(text ?? '', 5);
  }

  String getFirstWords(String sentence, int wordCounts) {
    try {
      return sentence.split(' ').sublist(0, wordCounts).join(' ');
    } catch (e) {
      return sentence;
    }
  }
}
