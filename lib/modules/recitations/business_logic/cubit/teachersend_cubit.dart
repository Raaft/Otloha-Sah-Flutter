import '../../../../core/error/exceptions.dart';
import '../../../../data_source/data_source.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data_source/models/database_model/teacher_response_entity.dart';

part 'teachersend_state.dart';

class TeacherSendCubit extends Cubit<TeacherSendState> {
  TeacherSendCubit() : super(TeacherSendInitial());
  List<TeacherResponse>? teachers;

  static TeacherSendCubit get(context) => BlocProvider.of(context);

  getTeacher() {
    emit(TeacherLoadingState());
    AppDataSource().getTeacher(1)!.then((value) async {
      if (value != null && value.results != null && value.results!.isNotEmpty) {
        teachers = value;

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
    return await AppDataSource().sendMessage(id, list);
  }
}
