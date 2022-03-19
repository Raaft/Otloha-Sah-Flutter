// ignore_for_file: empty_catches

import 'package:equatable/equatable.dart';
import 'package:flutter_base/modules/data/data_source/remote/data_source/user_recitation_api.dart';
import 'package:flutter_base/modules/data/model/recitations.dart';
import 'package:flutter_base/modules/messages/data/data_source/messages_servise.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'userrecitation_state.dart';

class UserRecitationCubit extends Cubit<UserRecitationState> {
  UserRecitationCubit() : super(UserRecitationInitial());
  Recitations? userRecitatios;

  static UserRecitationCubit get(context) => BlocProvider.of(context);

  fetchRecitation() async {
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
    } catch (e) {
      print(e);
    }
/*
    await AppDatabase()
        .userRecitationDao
        .findAllUserRecitations()
        .then((values) {
      if (values != null) {
        userRec!.addAll(values);
      }
    });*/

    if (userRec != null &&
        userRec!.results != null &&
        userRec!.results!.isNotEmpty) {
      for (var element in userRec!.results!) {
        /* element.narrationName = (await DataSource.instance
                .fetchNarrationById(element.narrationId ?? 0))!
            .name;

        element.chapterName = (await DataSource.instance
                .fetchChapterById(element.chapterId ?? 0))!
            .name;*/
      }
      userRecitatios = userRec;
      print(userRec);
      emit(UserRecitationFetched());
    } else {
      print('Error ' + userRec.toString());
      emit(UserRecitationError());
    }
  }

  markAsFinished(int id) async {
    await GetMessages().markAsFinished(id);
    fetchRecitation();
  }

  addToGeneral(int id) async {
    await GetMessages().addToGeneral(id);
    fetchRecitation();
  }

  deleteRecitations(int id) async {
    await GetMessages().deleteRecitations(id);
    fetchRecitation();
  }
}
/**
 *  Get.bottomSheet(PopupRecitation(finish: () {
          
        }, general: () {
          GetMessages().addToGeneral(results.owner!.id ?? 0, results.id ?? 0);
        }, delete: () {
          GetMessages().deleteRecitations(results.id ?? 0);
        }));
 */