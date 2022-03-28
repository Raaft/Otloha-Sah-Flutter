import 'package:flutter_base/core/error/exceptions.dart';
import 'package:flutter_base/modules/data/data_source/remote/data_source/user_api.dart';
import 'package:flutter_base/modules/data/model/teacher_response_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'teachersend_state.dart';

class TeacherSendCubit extends Cubit<TeacherSendState> {
  TeacherSendCubit() : super(TeacherSendInitial());
  TeacherResponse? teachers;

  static TeacherSendCubit get(context) => BlocProvider.of(context);

  getTeacher() {
    emit(TeacherLoadingState());
    UserApi().getTeacher()!.then((value) async {
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
    return await UserApi().sendMessage(id, list);
  }
}
