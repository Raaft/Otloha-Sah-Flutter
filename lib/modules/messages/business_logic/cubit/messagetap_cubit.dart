import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_base/core/error/exceptions.dart';
import 'package:flutter_base/modules/data/data_source/remote/data_source/user_recitation_api.dart';
import 'package:flutter_base/modules/data/model/GeneralResponse.dart';
import 'package:flutter_base/modules/messages/data/models/message_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_base/modules/messages/data/data_source/messages_servise.dart';

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

  List<GeneralResponse>? generalResponses;

  getListMessages() {
    emit(MessageLoadingState());
    GetMessages().getMessageListing()!.then((value) {
      if (value!.data != null) {
        messages = (value.data['results'] as List)
            .map((data) => MessageModel.fromJson(data))
            .toList();

        print('MessageModel is ===========> $messages');
        emit(MessageSuccessState());
      } else {
        emit(const MessageErrorState('Empty'));
      }
    }).catchError((error) {
      print('Error Finish' + error.toString());
      if (error is AuthError) {
        emit(NoAuthState());
        return;
      }
      emit(MessageErrorState(error.toString()));
    });
  }

  getRecieveMessage() {
    emit(MessageRecieveSuccessLoadingState());
    GetMessages().messgasRecieve()!.then((value) async {
      print('Status Code ${value!.statusCode}');
      if (value.statusCode == 200) {
        messageRecieve = (value.data['results'] as List)
            .map((data) => MessageModel.fromJson(data))
            .toList();
        print('MessageModel is ===========> $messageRecieve');
        if (messageRecieve != null && messageRecieve!.isNotEmpty) {
          for (var element in messageSendList!) {
            // element.recitation!.chapterName = (await DataSource.instance
            //             .fetchChapterById(element.recitation!.chapterId!))
            //         ?.name ??
            //     '';
            // element.recitation!.narrationName = (await DataSource.instance
            //             .fetchNarrationById(element.recitation!.narrationId!))
            //         ?.name ??
            //     '';
          }
          emit(MessageRecieveSuccessState());
        } else {
          emit(const MessageSendErrorState('No Data'));
        }
      } else {
        emit(const MessageSendErrorState('Error Code'));
      }
    }).catchError((error) {
      print('Error Finish' + error.toString());
      if (error is AuthError) {
        emit(NoAuthState());
        return;
      }
      emit(MessageRecieveErrorState(error.toString()));
    });
  }

  getSendMessage() {
    emit(MessageSendSuccessLoadingState());
    GetMessages().messagesSent()!.then((value) async {
      print('Status Code ${value!.statusCode}');

      if (value.statusCode == 200) {
        messageSendList = (value.data['results'] as List)
            .map((data) => MessageModel.fromJson(data))
            .toList();
        print('MessageModel is ===========> $messageSendList');
        if (messageSendList != null && messageSendList!.isNotEmpty) {
          for (var element in messageSendList!) {
            // element.recitation!.chapterName = (await DataSource.instance
            //             .fetchChapterById(element.recitation!.chapterId!))
            //         ?.name ??
            //     '';
            // element.recitation!.narrationName = (await DataSource.instance
            //             .fetchNarrationById(element.recitation!.narrationId!))
            //         ?.name ??
            //     '';
          }
          emit(MessageSendSuccessState());
        } else {
          emit(const MessageSendErrorState('No Data'));
        }
      } else {
        emit(const MessageSendErrorState('Error Code'));
      }
    }).catchError((error) {
      if (error is AuthError) {
        emit(NoAuthState());
        return;
      }
    });
  }

  getDetailsMessage({required int messageId}) {
    emit(MessageDetailsLoadingState());
    GetMessages().messageDetails(messageId: messageId).then((value) {
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
      emit(MessageDetailsErrorState(error.toString()));
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
      emit(MessageDetailsErrorState(error.toString()));
      return;
    });
    return;
  }

  getGeneraBoXMessage() async {
    emit(GenaralLoadingState());
    UserRecitationApi().getGeneraBoXMessage()!.then((value) async {
      if (value != null) {
        generalResponses = value;
        /*  for (var element in generalResponses!) {
          element.narrationName = (await DataSource.instance
                      .fetchNarrationById(element.narrationId ?? 0))!
                  .name ??
              '';
          element.chapterName = (await DataSource.instance
                      .fetchChapterById(element.chapterId ?? 0))!
                  .name ??
              '';
        }*/
        print('UserRecitation is ===========> $generalResponses');
        emit(GenaralSuccessState());
      } else {
        emit(const GenaralErrorState('No Data'));
      }
    }).catchError((error) {
      print('Error G ' + error.toString());
      if (error is AuthError) {
        emit(NoAuthState());
        return;
      }
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
