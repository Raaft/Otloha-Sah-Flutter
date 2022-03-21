part of 'teacherviewtype_cubit.dart';

abstract class TeacherviewtypeState {
  const TeacherviewtypeState();
}

class TeacherviewtypeInitial extends TeacherviewtypeState {}


class TeacherLoadingState extends TeacherviewtypeState {}

class TeacherFetchedState extends TeacherviewtypeState {}

class TeacherErrorState extends TeacherviewtypeState {}

class MarkAsFavTeacherLoadingState extends TeacherviewtypeState {}

class MarkAsFavTeacherFetchedState extends TeacherviewtypeState {}

class MarkAsFavTeacherErrorState extends TeacherviewtypeState {}

class TeacherviewtypeChange extends TeacherviewtypeState {
  final bool type;
  const TeacherviewtypeChange({
    required this.type,
  });
}

class NoAuthState extends TeacherviewtypeState {}
