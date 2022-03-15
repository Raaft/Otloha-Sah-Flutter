import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_base/modules/data/data_source/remote/data_source/user_recitation_api.dart';
import 'package:flutter_base/modules/data/model/user_recitation.dart';
import 'package:flutter_base/modules/messages/data/models/MessageModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_connect/http/src/response/response.dart';

import '../../data/data_source/messages_servise.dart';

part 'messagetap_state.dart';

class MessageTapCubit extends Cubit<MessageTapState> {
  MessageTapCubit() : super(MessageTapInitial());

  static MessageTapCubit get(context) => BlocProvider.of(context);
  changeIndex(int index) {
    emit(MessageTapInitial());
    emit(MessageTapChange(index: index));
  }

  List<MessageModel>? messages;
  List<MessageModel>? messageSendList;
  List<MessageModel>? messageRecieve;
  List<MessageModel>? messageDetails;
  List<MessageModel>? sendMessage;

  List<UserRecitation>? userRecitations;

  Future<Response>? getListMessages() {
    emit(MessageLoadingState());
    GetMessages().getMessageListing().then((value) {
      messages = (value.data as List)
          .map((data) => MessageModel.fromJson(data))
          .toList();
      print('MessageModel is ===========> $messages');
      emit(MessageSuccessState());
      return value;
    }).catchError((error) {
      print(error.toString());
      emit(MessageErrorState(error.toString()));
      return error;
    });
    return null;
  }

  Future<Response>? getRecieveMessage() {
    emit(MessageRecieveSuccessLoadingState());
    GetMessages().messgasRecieve().then((value) {
      messages = (value.data as List)
          .map((data) => MessageModel.fromJson(data))
          .toList();
      print('MessageModel is ===========> $messageRecieve');
      emit(MessageRecieveSuccessState());
      return value;
    }).catchError((error) {
      print(error.toString());
      emit(MessageRecieveErrorState(error.toString()));
      return error;
    });
    return null;
  }

  Future<Response>? getSendMessage() {
    emit(MessageSendSuccessLoadingState());
    GetMessages().messagesSent().then((value) {
      messages = (value.data as List)
          .map((data) => MessageModel.fromJson(data))
          .toList();
      print('MessageModel is ===========> $messageSendList');
      emit(MessageSendSuccessState());
      return value;
    }).catchError((error) {
      print(error.toString());
      emit(MessageSendErrorState(error.toString()));
      return error;
    });
    return null;
  }

  Future<Response>? getDetailsMessage({required int messageId}) {
    emit(MessageDetailsLoadingState());
    GetMessages().messageDetails(messageId: messageId).then((value) {
      messages = (value.data as List)
          .map((data) => MessageModel.fromJson(data))
          .toList();
      print('MessageModel is ===========> $messageDetails');
      emit(MessageDetailsSuccessState());
      return value;
    }).catchError((error) {
      print(error.toString());
      emit(MessageDetailsErrorState(error.toString()));
      return error;
    });
    return null;
  }

  Future<Response>? sendMessageRequest({required int messageId}) {
    emit(SendMessageLoadingState());
    GetMessages().sendMessage(messageId: messageId).then((value) {
      messages = (value.data as List)
          .map((data) => MessageModel.fromJson(data))
          .toList();
      print('MessageModel is ===========> $sendMessage');
      emit(MessageDetailsSuccessState());
      return value;
    }).catchError((error) {
      print(error.toString());
      emit(MessageDetailsErrorState(error.toString()));
      return error;
    });
    return null;
  }

  getGeneraBoXMessage() async {
    emit(GenaralLoadingState());
    UserRecitationApi().getGeneraBoXMessage()!.then((value) {
      userRecitations = value;
      print('UserRecitation is ===========> $userRecitations');
      emit(GenaralSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GenaralErrorState(error.toString()));
    });
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
}
