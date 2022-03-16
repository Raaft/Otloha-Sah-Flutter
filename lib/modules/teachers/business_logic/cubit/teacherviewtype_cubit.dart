import 'package:flutter_base/modules/data/data_source/remote/data_source/user_api.dart';
import 'package:flutter_base/modules/data/model/teacher_response_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_widget_flutter/data_source/data_source.dart';

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
        for (var element in teachers!.results!) {
          element.narrationName = (await DataSource.instance
                      .fetchNarrationById(element.narrationId ?? 1))!
                  .name ??
              '';
        }
        emit(TeacherFetchedState());
      } else {
        emit(TeacherFetchedState());
      }
    }).catchError((e) {
      print('Error $e');
      emit(TeacherFetchedState());
    });
  }
}
