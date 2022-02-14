part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}


class IsLikedTrueState extends HomeState {}
class IsLikedFalseState extends HomeState {}
class IsOnPressState extends HomeState {}
class IsBookMarkTrueState extends HomeState {}
class IsBookMarkFalseState extends HomeState {}
class IsRecordedState extends HomeState {}
class IsRecordedFileState extends HomeState {}

class HomeChangeIndex extends HomeState {
  final int index;

  const HomeChangeIndex(this.index);
}
