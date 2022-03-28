import 'package:flutter_base/core/error/exceptions.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data_source/models/database_model/teacher_response_entity.dart';
import '../../../../data_source/remote/database_source/user_api.dart';

part 'teachersend_state.dart';

class TeachersendCubit extends Cubit<TeachersendState> {
  TeachersendCubit() : super(TeachersendInitial());
  TeacherResponse? teachers;

  static TeachersendCubit get(context) => BlocProvider.of(context);

  getTeacher() {
    emit(TeacherLoadingState());
    UserApi().getTeacher()!.then((value) async {
      if (value != null && value.results != null && value.results!.isNotEmpty) {
        teachers = value as TeacherResponse?;

        // print('teachers ' + teachers!.toString());

        emit(TeacherFetchedState());
      } else {
        emit(TeacherErrorState());
      }
    }).catchError((e) {
      print('Error $e');
      print('Error G ' + e.toString());
      if (e is AuthError) {
        emit(NoAuthState());
        return;
      }
      emit(TeacherErrorState());
    });
  }

  filter({String? qurey}) {}

  Future<String?>? sendMessage(List<int> list, int id) async {
    return await UserApi().sendMessage(id, list);
  }
}
