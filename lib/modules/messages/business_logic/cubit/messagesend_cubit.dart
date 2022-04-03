import 'package:flutter_base/core/error/exceptions.dart';
import 'package:flutter_base/data_source/models/message_model/message_model.dart';
import 'package:flutter_base/data_source/remote/messages_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'messagesend_state.dart';

class MessagesendCubit extends Cubit<MessagesendState> {
  MessagesendCubit() : super(MessagesendInitial());

  static MessagesendCubit get(context) => BlocProvider.of(context);

  List<MessageModel>? messageSendList;

  getSendMessage() async {
    emit(MessageSendSuccessLoadingState());
    GetMessages().messagesSent().then((value) async {
      messageSendList = (value!.data['results'] as List)
          .map((data) => MessageModel.fromJson(data))
          .toList();
      emit(MessageSendSuccessState());

      if (messageSendList!.isEmpty) {
        emit(MessageSendErrorState(EmptyListException()));
      }
    }).catchError((error) {
      emit(MessageSendErrorState(error));
    });

    // try {
    //   Response? response = await GetMessages().messagesSent();
    //   messageSendList = (response!.data['results'] as List)
    //       .map((data) => MessageModel.fromJson(data))
    //       .toList();
    //   print('MessageModel is ===========> $messageSendList');
    // } on Exception catch (e) {
    //   emit(MessageErrorState(e));
    // }
    // if (messageSendList != null && messageSendList!.isNotEmpty) {
    //   emit(MessageSendSuccessState());
    // }
  }

  getNextSendData(int? nextLink) async {
    return await GetMessages().messagesSent(nextLink: nextLink);
  }
}
