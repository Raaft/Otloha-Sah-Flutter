import 'package:flutter_base/core/utils/constant/constants.dart';
import 'package:flutter_base/data_source/cache_helper.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../data_source/data_source.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data_source/models/database_model/teacher_response_entity.dart';

part 'teachersend_state.dart';

class TeacherSendCubit extends Cubit<TeacherSendState> {
  TeacherSendCubit() : super(TeacherSendInitial());
  List<TeacherResponse?>? teachers = [];

  static TeacherSendCubit get(context) => BlocProvider.of(context);

  getTeacher() {
    try {
      emit(TeacherLoadingState());
      teachers!.add(CacheHelper.getData(key: favTeacher));
      emit(TeacherFetchedState());
    } catch (e) {
      emit(TeacherErrorState());
    }
  }

  filter({String? qurey}) {}

  Future<String?>? sendMessage(List<int> list, int id) async {
    return await AppDataSource().sendMessage(id, list);
  }
}
