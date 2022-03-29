import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_base/core/error/exceptions.dart';
import 'package:flutter_base/data_source/data_source.dart';
import 'package:flutter_base/data_source/models/database_model/teacher_response_entity.dart';

import 'package:flutter_bloc/flutter_bloc.dart';


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
    AppDataSource().getTeacher()!.then((value) async {
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

  markAsFavTeacher({ int? id}) async {
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
    AppDataSource().getStudents()!.then((value) async {
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
