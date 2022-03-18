// ignore_for_file: empty_catches

import 'package:equatable/equatable.dart';
import 'package:flutter_base/modules/data/data_source/local/database/database/database.dart';
import 'package:flutter_base/modules/data/data_source/remote/data_source/user_recitation_api.dart';
import 'package:flutter_base/modules/data/model/user_recitation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'userrecitation_state.dart';

class UserRecitationCubit extends Cubit<UserRecitationState> {
  UserRecitationCubit() : super(UserRecitationInitial());
  List<UserRecitation>? userRecitatios = [];

  static UserRecitationCubit get(context) => BlocProvider.of(context);

  fetchLoacl() async {
    List<UserRecitation>? userRec = [];

    try {
      await UserRecitationApi().getUserReciataions()!.then((value) {
        print(value);
        if (value.isNotEmpty) {
          userRec = value;
        }
      });
    } catch (e) {
      print(e);
    }

    await AppDatabase()
        .userRecitationDao
        .findAllUserRecitations()
        .then((values) {
      if (values != null) {
        userRec!.addAll(values);
      }
    });

    if (userRec != null && userRec!.isNotEmpty) {
      userRecitatios = userRec;
      print(userRec);
      emit(UserRecitationFetched());
    } else {
      print('Error ' + userRec.toString());
      emit(UserRecitationError());
    }
  }
}
