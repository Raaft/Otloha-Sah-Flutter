import 'package:flutter_base/core/error/exceptions.dart';
import 'package:flutter_base/modules/data/data_source/remote/data_source/user_api.dart';
import 'package:flutter_base/modules/data/model/teacher_response_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/data_sourse/teacher_servises.dart';

part 'teacherviewtype_state.dart';

class TeacherviewtypeCubit extends Cubit<TeacherviewtypeState> {
  TeacherviewtypeCubit() : super(TeacherviewtypeInitial());
  TeacherResponse? teachers;

  static TeacherviewtypeCubit get(context) => BlocProvider.of(context);

  changeType(bool type) {
    emit(TeacherviewtypeChange(type: type));
  }

  getTeacher() {
    emit(TeacherLoadingState());
    UserApi().getTeacher()!.then((value) async {
      if (value != null && value.results != null && value.results!.isNotEmpty) {
        teachers = value;
        /*   for (var element in teachers!.results!) {
          element.narrationName = (await DataSource.instance
                      .fetchNarrationById(element.narrationId ?? 1))!
                  .name ??
              '';
        }*/
        emit(TeacherFetchedState());
      } else {
        print('Error e');
        emit(TeacherErrorState());
      }
    }).catchError((e) {
      print('Error $e');
      //  print('Error G ' + e.toString());
      if (e is AuthError) {
        emit(NoAuthState());
        return;
      }
      emit(TeacherErrorState());
    });
  }

  markAsFavTeacher({ int? id}) async {
    emit(MarkAsFavTeacherLoadingState());
    TeacherDataService().markAsFavTeacher(id: id)!.then((value) {
      return value;
    }).catchError((e) {
      print('Error $e');
      //  print('Error G ' + e.toString());
      if (e is AuthError) {
        emit(NoAuthState());
      }
      emit(MarkAsFavTeacherErrorState());
    });
  }

  getStudents() {
    emit(TeacherLoadingState());
    UserApi().getStudents()!.then((value) async {
      if (value != null && value.results != null && value.results!.isNotEmpty) {
        teachers = value;
        /* for (var element in teachers!.results!) {
          element.narrationName = (await DataSource.instance
                      .fetchNarrationById(element.narrationId ?? 1))!
                  .name ??
              '';
        }*/
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
}
