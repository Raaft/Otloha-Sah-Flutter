import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_base/core/network/api_base_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../data_source/data_source.dart';
import '../../../../data_source/models/database_model/teacher_response_entity.dart';

part 'teacherviewtype_state.dart';

class TeacherviewtypeCubit extends Cubit<TeacherviewtypeState> {
  TeacherviewtypeCubit() : super(TeacherviewtypeInitial());
  List<TeacherResponse>? teachers;

  static TeacherviewtypeCubit get(context) => BlocProvider.of(context);

  changeType(bool type) {
    emit(TeacherviewtypeChange(type: type));
  }

  getTeacher() {
    emit(TeacherLoadingState());
    AppDataSource().getTeacher(1)!.then((value) async {
      if (value != null && value.isNotEmpty) {
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
        emit(TeacherErrorState(EmptyListException()));
      }
    }).catchError((e) {
      print('Error $e');
      //  print('Error G ' + e.toString());
      if (e is AuthError) {
        emit(NoAuthState());
        return;
      }
      emit(TeacherErrorState(e));
    });
  }

  markAsFavTeacher({int? id}) async {
    emit(MarkAsFavTeacherLoadingState());
    AppDataSource().markAsFavTeacher(id: id).then((value) {
      emit(MarkAsFavTeacherFetchedState());
      getTeacher();
      return value;
    }).catchError((e) {
      print('Error $e');
      //  print('Error G ' + e.toString());
      if (e is AuthError) {
        emit(NoAuthState());
      }
      emit(MarkAsFavTeacherErrorState(e));
    });
  }

  getStudents() {
    emit(TeacherLoadingState());
    AppDataSource().getStudents(1).then((value) async {
      if (value != null && value.isNotEmpty) {
        teachers = value;
        /* for (var element in teachers!.results!) {
          element.narrationName = (await DataSource.instance
                      .fetchNarrationById(element.narrationId ?? 1))!
                  .name ??
              '';
        }*/
        emit(TeacherFetchedState());
      } else {
        emit(TeacherErrorState(EmptyListException()));
      }
    }).catchError((e) {
      print('Error $e');
      print('Error G ' + e.toString());
      if (e is AuthError) {
        emit(NoAuthState());
        return;
      }
      emit(TeacherErrorState(e));
    });
  }

  Future<File?>? uploadFile() async {
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

  getNextTeachers(int nextLink) async {
    return ApiBaseHelper().getHTTP('/api/v1/users/teachers/',
        queryParameters: {'page': nextLink});
  }

  getNextStudents(int nextLink) async {
    return ApiBaseHelper().getHTTP('/api/v1/users/students/',
        queryParameters: {'page': nextLink});
  }
}
