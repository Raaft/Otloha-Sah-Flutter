import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_base/data_source/data_source.dart';
import 'package:flutter_base/data_source/models/setting_model/setting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());
  static SettingsCubit get(context) => BlocProvider.of(context);

  changeSetting(List<Settings> settings) {
    emit(SettingsChange(settings: settings));
  }

  changeSettingDwon(List<Settings> settings) {
    emit(SettingsChangeDown(settings: settings));
  }

  updatePhone({required phone, required password}) {
    emit(UpdatePhoneLoadingState());
    AppDataSource().updatePhone(phone: phone, password: password).then((value) {
      print('UserRecitation is ===========> $value');
      emit(UpdatePhoneSuccessState(value));
    }).catchError((error) {
      print('Error G ' + error.toString());
      emit(UpdatePhoneErrorState(error));

      emit(UpdatePhoneErrorState(error.toString()));
    });
  }

  updateEmail({required email, required password}) {
    emit(UpdateEmailLoadingState());
    AppDataSource().updateEmail(email: email, password: password).then((value) {
      print('UserRecitation is ===========> $value');
      emit(UpdateEmailSuccessState(value));
    }).catchError((error) {
      print('Error G ' + error.toString());
      emit(UpdateEmailErrorState(error));
    });
  }
  regiAsTeacher({required FormData data}) {
    emit(RegisterAsTeacherLoadingState());
    AppDataSource().registerAsATeacher(data).then((value) {
      print('RegisterAsTeacher is ===========> $value');
      emit(RegisterAsTeacherSuccessState(value));
    }).catchError((error) {
      print('Error RegisterAsTeacher ' + error.toString());
      emit(RegisterAsTeacherErrorState(error));
    });
  }

  changePassword(
      {required oldPassword, required newPassword, required confirmPassword}) {
    emit(ChangePasswordLoadingState());
    AppDataSource()
        .changePassword(
            oldPassword: oldPassword,
            newPassword: newPassword,
            confirmPassword: confirmPassword)
        .then((value) {
      print('UserRecitation is ===========> $value');
      emit(ChangePasswordSuccessState(value));
    }).catchError((error) {
      print('Error G ' + error.toString());
      emit(ChangePasswordErrorState(error));
    });
  }

  Future<File?>? uploadFile()async{
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      emit(state);
      return file;
    } else {
      // User canceled the picker
    }
    return null;
  }

}
