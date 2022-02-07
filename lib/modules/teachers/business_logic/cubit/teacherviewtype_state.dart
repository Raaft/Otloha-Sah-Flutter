part of 'teacherviewtype_cubit.dart';

abstract class TeacherviewtypeState extends Equatable {
  const TeacherviewtypeState();

  @override
  List<Object> get props => [];
}

class TeacherviewtypeInitial extends TeacherviewtypeState {}

class TeacherviewtypeChange extends TeacherviewtypeState {
  final bool type;
  const TeacherviewtypeChange({
    required this.type,
  });
}
