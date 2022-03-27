import 'package:flutter_base/modules/data/data_source/remote/data_source/message_api.dart';
import 'package:flutter_base/modules/data/model/recitaion_details.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_widget_flutter/data_source/data_source.dart';
import 'package:quran_widget_flutter/model/verse.dart';

import '../../../../data_source/models/message_model/message_delails.dart';
import '../../../../data_source/remote/messages_service.dart';

part 'messagedetails_state.dart';

class MessagedetailsCubit extends Cubit<MessagedetailsState> {
  static MessagedetailsCubit get(context) => BlocProvider.of(context);
  MessagedetailsCubit() : super(MessagedetailsInitial());

  MessageDelails? messageDetails;
  RecitationDetails? recitationDetails;
  String ayah = '';

  fetchMessages(int msgId, int recitationId) async {
    ayah = '';
    emit(MessageLoadingState());
    MessageApi().messageDetails(msgId, recitationId).then((value) async {
      print('object $value');
      if (value != null) {
        messageDetails = value;
        for (var element in messageDetails!.recitation!.verseIds!) {
          Verse? text = await DataSource.instance.fetchVerseById(element);
          if (text != null) {
            ayah += '  ' + text.uthmanicText!;
            print(ayah);
          } else {
            print('not found ayah $element');
          }
        }
        print(messageDetails!.recitation!.name);
        emit(MessageFetchedState());
      } else {
        print('object not data');
        emit(MessageErrorState());
      }
    });
    // .catchError((error) {
    //   print('error $error');
    //   emit(MessageErrorState());
    // });
  }

  fetchRecitation(int recitationId) async {
    ayah = '';
    emit(MessageLoadingState());
    MessageApi().recitationDetails(recitationId).then((value) async {
      print('object $value');
      if (value != null) {
        recitationDetails = value;
        for (var element in recitationDetails!.verseIds!) {
          Verse? text = await DataSource.instance.fetchVerseById(element);
          if (text != null) {
            ayah += '  ' + text.uthmanicText!;
            print(ayah);
          } else {
            print('not found ayah $element');
          }
        }
        print(recitationDetails!.name);
        emit(MessageFetchedState());
      } else {
        print('object not data');
        emit(MessageErrorState());
      }
    });
    // .catchError((error) {
    //   print('error $error');
    //   emit(MessageErrorState());
    // });
  }

  markAsFinished(int id) async {
    await GetMessages().markAsFinished(id);
    fetchRecitation(id);
  }

  addToGeneral(int id) async {
    await GetMessages().addToGeneral(id);
    fetchRecitation(id);
  }

  deleteRecitations(int id) async {
    await GetMessages().deleteRecitations(id);
    fetchRecitation(id);
  }
}
