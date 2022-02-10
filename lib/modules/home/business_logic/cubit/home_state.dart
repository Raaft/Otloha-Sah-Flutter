part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}


class IsLikedState extends HomeState {}
class IsOnPressState extends HomeState {}
class IsBookMarkState extends HomeState {}
class IsRecordedState extends HomeState {}

class HomeChangeIndex extends HomeState {
  final int index;

  const HomeChangeIndex(this.index);
}
