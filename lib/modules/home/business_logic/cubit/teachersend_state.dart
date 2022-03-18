part of 'teachersend_cubit.dart';

abstract class TeachersendState {
  const TeachersendState();
}

class TeachersendInitial extends TeachersendState {}

class TeacherFetchedState extends TeachersendState {}

class TeacherLoadingState extends TeachersendState {}

class NoAuthState extends TeachersendState {}

class TeacherErrorState extends TeachersendState {}
