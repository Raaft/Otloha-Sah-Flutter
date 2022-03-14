import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_base/modules/data/data_source/local/database/database/database.dart';

part 'userrecitation_state.dart';

class UserRecitationCubit extends Cubit<UserRecitationState> {
  UserRecitationCubit() : super(UserRecitationInitial());

  fetchLoacl() {
    AppDatabase().userRecitationDao.findAllUserRecitations().then((value) {
      if (value != null) {}
    });
  }
}
