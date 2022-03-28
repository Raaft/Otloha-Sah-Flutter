import 'package:flutter_base/core/error/exceptions.dart';
import 'package:flutter_base/modules/data/data_source/remote/data_source/user_recitation_api.dart';
import 'package:flutter_base/modules/data/model/recitations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_widget_flutter/model/verse.dart';
import 'package:quran_widget_flutter/quran_widget_flutter.dart';

part 'userrecitation_state.dart';

class UserRecitationCubit extends Cubit<UserRecitationState> {
  UserRecitationCubit() : super(UserRecitationInitial());
  Recitations? userRecitatios;
  List<List<Verse>> userRecitationVerses = [];

  static UserRecitationCubit get(context) => BlocProvider.of(context);

  Future fetchRecitation() async {
    Recitations? userRec;

    try {
      await UserRecitationApi().getUserReciataions()!.then((value) {
        print(value);
        if (value != null &&
            value.results != null &&
            value.results!.isNotEmpty) {
          userRec = value;
        }
      });
    } on AuthError catch (_) {
      emit(AuthErrorState());
      return;
    }

    if (userRec != null &&
        userRec!.results != null &&
        userRec!.results!.isNotEmpty) {
      userRecitatios = userRec;
      for (var recitation in userRec!.results!) {
        List<Verse> verses = [];
        for (int verseId in recitation.versesID!) {
          print(await DataSource.instance.fetchVerseById(verseId));
          Verse? verse = await DataSource.instance.fetchVerseById(verseId);
          verses.add(verse!);
        }
        userRecitationVerses.add(verses);
      }
      emit(UserRecitationFetched());
    } else {
      print('Error ' + userRec.toString());
      emit(UserRecitationError());
    }
  }

  deleteRecitation(int index) {
    userRecitatios!.results!.removeAt(index);
    if (userRecitatios!.results!.isEmpty) {
      emit(UserRecitationError());
    } else {
      emit(RemoveUserRecitationState());
    }
  }
}
