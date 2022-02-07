import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'teacherviewtype_state.dart';

class TeacherviewtypeCubit extends Cubit<TeacherviewtypeState> {
  TeacherviewtypeCubit() : super(TeacherviewtypeInitial());

  changeType(bool type) {
    emit(TeacherviewtypeInitial());
    emit(TeacherviewtypeChange(type: type));
  }
}
