// ignore_for_file: empty_catches

import 'package:dio/src/response.dart';
import 'package:flutter_base/core/error/exceptions.dart';
import 'package:flutter_base/core/network/api_base_helper.dart';
import 'package:flutter_base/data_source/data_source.dart';
import 'package:flutter_base/data_source/models/database_model/recitations.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_widget_flutter/model/verse.dart';
import 'package:quran_widget_flutter/quran_widget_flutter.dart';

part 'userrecitation_state.dart';

class UserRecitationCubit extends Cubit<UserRecitationState> {
  UserRecitationCubit() : super(UserRecitationInitial());
  List<Recitations>? userRecitatios;
  List<List<Verse>> userRecitationVerses = [];

  static UserRecitationCubit get(context) => BlocProvider.of(context);

  Future fetchRecitation() async {
    List<Recitations>? userRec;

    try {
      await AppDataSource().getUserReciataions(1)!.then((value) {
        print(value);
        if (value != null && value.isNotEmpty) {
          userRec = value;
        }
      });
    } on AuthError catch (_) {
      emit(AuthErrorState());
      return;
    }

    if (userRec != null && userRec!.isNotEmpty) {
      userRecitatios = userRec;
      for (var recitation in userRec!) {
        List<Verse> verses = [];
        for (int verseId in recitation.versesID!) {
          print(await DataSource.instance.fetchVerseById(verseId));
          Verse? verse = await DataSource.instance.fetchVerseById(verseId);
          verses.add(verse!);
        }
        userRecitationVerses.add(verses);
        if (userRecitationVerses.isEmpty) {
          emit(UserRecitationError(EmptyListException()));
        }
      }
      emit(UserRecitationFetched());
    } else {
      print('Error ' + userRec.toString());
      emit(UserRecitationError(EmptyListException()));
    }
  }

  deleteRecitation(int index) {
    userRecitatios!.removeAt(index);
    if (userRecitatios!.isEmpty) {
      emit(UserRecitationError(EmptyListException()));
    } else {
      emit(RemoveUserRecitationState());
    }
  }

  getNextData(int nextLink) async {
    return await ApiBaseHelper()
        .getHTTP('/api/v1/recitations/', queryParameters: {'page': nextLink});
  }
}
