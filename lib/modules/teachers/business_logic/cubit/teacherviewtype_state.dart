part of 'teacherviewtype_cubit.dart';

abstract class TeacherviewtypeState {
  const TeacherviewtypeState();
}

class TeacherviewtypeInitial extends TeacherviewtypeState {}

class TeacherFetchedState extends TeacherviewtypeState {}

class TeacherLoadingState extends TeacherviewtypeState {}

class TeacherErrorState extends TeacherviewtypeState {}

class TeacherviewtypeChange extends TeacherviewtypeState {
  final bool type;
  const TeacherviewtypeChange({
    required this.type,
  });
}
