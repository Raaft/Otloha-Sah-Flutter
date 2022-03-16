import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_base/modules/settings/data/models/setting.dart';

import '../../data/update_profile_web_servises.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());

  changeSetting(List<Settings> settings) {
    emit(SettingsChange(settings: settings));
  }

  changeSettingDwon(List<Settings> settings) {
    emit(SettingsChangeDown(settings: settings));
  }

  updatePhone({required phone, required password})  {
    emit(UpdatePhoneLoadingState());
    UpdateProfile()
        .updatePhone(phone: phone, password: password)
        .then((value) {
      print('UserRecitation is ===========> $value');
      emit(UpdatePhoneSuccessState(value));
    }).catchError((error) {
      print('Error G ' + error.toString());
      emit(UpdatePhoneErrorState(error));

      emit(UpdatePhoneErrorState(error.toString()));
    });
  }
  updateEmail({required email, required password})  {
    emit(UpdateEmailLoadingState());
    UpdateProfile()
        .updateEmail(email: email, password: password)
        .then((value) {
      print('UserRecitation is ===========> $value');
      emit(UpdateEmailSuccessState(value));
    }).catchError((error) {
      print('Error G ' + error.toString());
      emit(UpdateEmailErrorState(error));

    });
  }
  changePassword(
      {required oldPassword,
        required newPassword,
        required confirmPassword}) {
    emit(ChangePasswordLoadingState());
    UpdateProfile()
        .changePassword(oldPassword: oldPassword, newPassword: newPassword, confirmPassword: confirmPassword)
        .then((value) {
      print('UserRecitation is ===========> $value');
      emit(ChangePasswordSuccessState(value));
    }).catchError((error) {
      print('Error G ' + error.toString());
      emit(ChangePasswordErrorState(error));

    });
  }
  
  
}
