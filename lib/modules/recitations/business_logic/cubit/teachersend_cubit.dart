import 'dart:convert';

import 'package:flutter_base/core/utils/constant/constants.dart';
import 'package:flutter_base/data_source/cache_helper.dart';

import '../../../../data_source/data_source.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data_source/models/database_model/teacher_response_entity.dart';

part 'teachersend_state.dart';

class TeacherSendCubit extends Cubit<TeacherSendState> {
  TeacherSendCubit() : super(TeacherSendInitial());
  List<TeacherResponse> teachers = [];

  static TeacherSendCubit get(context) => BlocProvider.of(context);

  getTeacher() {
    try {
      emit(TeacherLoadingState());
      if (CacheHelper.getData(key: favTeacher) != null) {
        TeacherResponse favTeacherProFile = TeacherResponse.fromJson(
            jsonDecode(CacheHelper.getData(key: favTeacher)));
        teachers.add(favTeacherProFile);
        emit(TeacherFetchedState());
      } else {
        emit(TeacherErrorState());
      }
    } catch (e) {
      print('e $e');
      emit(TeacherErrorState());
    }
  }

  filter({String? qurey}) {}

  Future<String?>? sendMessage(List<int> list, int id) async {
    return await AppDataSource().sendMessage(id, list);
  }

  sendTeacher(int id) async {
    if (favTeacherId != null) {
      // Get.dialog(const AlertDialogFullScreen());

      var res = await AppDataSource().sendMessage(
        id,
        [favTeacherId ?? 0],
      );

      emit(TeacherFetchedState());

      return res;
    }
    emit(TeacherErrorState());
  }
}
