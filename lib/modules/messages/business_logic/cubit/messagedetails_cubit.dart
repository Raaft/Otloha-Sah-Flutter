import 'package:flutter_base/core/network/api_base_helper.dart';
import 'package:flutter_base/modules/data/data_source/remote/data_source/message_api.dart';
import 'package:flutter_base/modules/messages/data/models/message_delails.dart';
import 'package:flutter_base/modules/messages/data/models/message_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_widget_flutter/data_source/data_source.dart';
import 'package:quran_widget_flutter/model/verse.dart';

part 'messagedetails_state.dart';

class MessagedetailsCubit extends Cubit<MessagedetailsState> {
  static MessagedetailsCubit get(context) => BlocProvider.of(context);
  MessagedetailsCubit() : super(MessagedetailsInitial());

  MessageDelails? messageModel;
  String ayah = '';

  fetchMessages(int msgId, int recitationId) async {
    emit(MessageLoadingState());
    MessageApi().messageDetails(msgId, recitationId).then((value) {
      print('object $value');
      if (value != null) {
        messageModel = value;
        messageModel!.results![0].recitation!.verseIds!
            .forEach((element) async {
          Verse? text = await DataSource.instance.fetchVerseById(element);
          ayah += text!.uthmanicText!;
        });
        emit(MessageFetchedState());
      } else {
        print('object');
        emit(MessageErrorState());
      }
    }).then((value) {
      print('object $value');
      emit(MessageErrorState());
    });
  }
}
