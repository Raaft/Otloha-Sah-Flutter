import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';

import '../../../../core/error/exceptions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data_source/models/message_model/message_model.dart';
import '../../../../data_source/remote/messages_service.dart';

part 'messagetap_state.dart';

class MessageTapCubit extends Cubit<MessageTapState> {
  MessageTapCubit() : super(MessageTapInitial());

  static MessageTapCubit get(context) => BlocProvider.of(context);

  int index = 0;

  changeIndex(int value) {
    index = value;
    emit(MessageTapChange(index: index));
  }

  List<MessageModel>? messages;
  List<MessageModel>? messageDetails;
  List<MessageModel>? sendMessage;

  getListMessages() async {
    emit(MessageLoadingState());
    try {
      Response? res = await GetMessages().getMessageListing();
      messages = (res!.data['results'] as List)
          .map((data) => MessageModel.fromJson(data))
          .toList();
      if (messages!.isEmpty) {
        emit(MessageErrorState(EmptyListException()));
      } else {
        emit(MessageSuccessState());
      }
    } on Exception catch (e, _) {
      print(e);
      print('asdds');
      emit(MessageErrorState(e));
    }
  }

  getDetailsMessage({required int messageId, required int recitationId}) {
    emit(MessageDetailsLoadingState());
    GetMessages()
        .messageDetails(messageId: messageId, recitationId: recitationId)
        .then((value) {
      messages = (value!.data['results'] as List)
          .map((data) => MessageModel.fromJson(data))
          .toList();
      print('MessageModel is ===========> $messageDetails');
      emit(MessageDetailsSuccessState());
      return;
    }).catchError((error) {
      print(error.toString());
      if (error is AuthError) {
        emit(NoAuthState());
        return;
      }
      emit(MessageDetailsErrorState(error));
      return;
    }).catchError((error) {
      if (error is AuthError) {
        emit(NoAuthState());
        return;
      }
    });
    return;
  }

  sendMessageRequest({required int messageId}) {
    emit(SendMessageLoadingState());
    GetMessages().sendMessage(messageId: messageId).then((value) {
      messages = (value!.data['results'] as List)
          .map((data) => MessageModel.fromJson(data))
          .toList();
      print('MessageModel is ===========> $sendMessage');
      emit(MessageDetailsSuccessState());
      return;
    }).catchError((error) {
      print(error.toString());
      if (error is AuthError) {
        emit(NoAuthState());
        return;
      }
      emit(MessageDetailsErrorState(error));
      return;
    });
    return;
  }

  markAsAccept({required int messageId, required int reciId}) {
    emit(MarkAsAcceptLoadingState());
    GetMessages()
        .markAsAccepted(id: reciId, messageId: messageId)
        .then((value) {
      messages = (value.data['results'] as List)
          .map((data) => MessageModel.fromJson(data))
          .toList();
      print('MessageModel is ===========> $sendMessage');
      emit(MarkAsAcceptSuccessState());
      return;
    }).catchError((error) {
      print(error.toString());
      if (error is AuthError) {
        emit(NoAuthState());
        return;
      }
      emit(MarkAsAcceptErrorState(error.toString()));
      return;
    });
    return;
  }

  markAsRead({required int messageId, required int reciId}) {
    emit(MarkAsReadLoadingState());
    GetMessages()
        .markAsAccepted(id: reciId, messageId: messageId)
        .then((value) {
      messages = (value.data['results'] as List)
          .map((data) => MessageModel.fromJson(data))
          .toList();
      print('MessageModel is ===========> $sendMessage');
      emit(MarkAsReadSuccessState());
      return;
    }).catchError((error) {
      print(error.toString());
      if (error is AuthError) {
        emit(NoAuthState());
        return;
      }
      emit(MarkAsReadErrorState(error.toString()));
      return;
    });
    return;
  }

  markAsRemarkable({required int messageId, required int reciId}) {
    emit(MarkAsRemarkableLoadingState());
    GetMessages()
        .markAsRemarkable(id: reciId, messageId: messageId)
        .then((value) {
      messages = (value.data['results'] as List)
          .map((data) => MessageModel.fromJson(data))
          .toList();
      print('MessageModel is ===========> $sendMessage');
      emit(MarkAsRemarkableSuccessState());
      return;
    }).catchError((error) {
      print(error.toString());
      if (error is AuthError) {
        emit(NoAuthState());
        return;
      }
      emit(MarkAsRemarkableErrorState(error.toString()));
      return;
    });
    return;
  }

  sendMessageAsTeacher({required int messageId, required int reciId}) async {
    await GetMessages().sendMessageAsTeacher(reciId, messageId);
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
      if (isPlay) {
        timer.cancel();
      }
      var time = await advancedPlayer!.getCurrentPosition();
      position = Duration(microseconds: time);
    });
  }

  bool isPlay = false;

  void startNewRoute() async {
    await playSound('waveform.mp3');
    // more code here
  }

  void search({String? qurey}) {}
}
