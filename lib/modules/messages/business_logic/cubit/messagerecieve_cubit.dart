import 'package:flutter_base/core/error/exceptions.dart';
import 'package:flutter_base/data_source/models/message_model/message_model.dart';
import 'package:flutter_base/data_source/remote/messages_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'messagerecieve_state.dart';

class MessagerecieveCubit extends Cubit<MessagerecieveState> {
  MessagerecieveCubit() : super(MessagerecieveInitial());

  List<MessageModel>? messageRecieve;
  static MessagerecieveCubit get(context) => BlocProvider.of(context);

  getRecieveMessage() async {
    emit(MessageRecieveSuccessLoadingState());
    GetMessages().messgasRecieve()!.then((value) async {
      messageRecieve = messageRecieve = (value!.data['results'] as List)
          .map((data) => MessageModel.fromJson(data))
          .toList();
      emit(MessageRecieveSuccessState());
      if (messageRecieve!.isEmpty) {
        emit(MessageRecieveErrorState(EmptyListException()));
      }
    }).catchError((error) {
      print('Error G ' + error.toString());
      if (error is AuthError) {
        emit(NoAuthState());
        return;
      }
      emit(MessageRecieveErrorState(error));
    });

    // try {
    //   Response? response = await GetMessages().messgasRecieve();
    //
    //   if (response!.statusCode == 200) {
    //     messageRecieve = (response.data['results'] as List)
    //         .map((data) => MessageModel.fromJson(data))
    //         .toList();
    //     print(
    //         'MessageModel is ===========> $messageRecieve ${messageRecieve != null}');
    //
    //     emit(MessageRecieveSuccessState());
    //   }
    // } on Exception catch (e) {
    //   emit(MessageErrorState(e));
    // }
    // if (messageRecieve!.isEmpty) {
    //   emit(MessageSendErrorState(EmptyListException()));
    // }
  }

  getNextRecieveData(int nextLink) async {
    return await GetMessages().messgasRecieve(nextLink: nextLink);
  }
}
