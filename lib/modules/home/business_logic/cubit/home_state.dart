part of 'home_cubit.dart';

abstract class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {}

class HomeChangeIndex extends HomeState {
  final int index;

  const HomeChangeIndex(this.index);
}

class IsFloatingTrueMenuState extends HomeState {}

class ChangePageState extends HomeState {}

class ChangePageFalseState extends HomeState {}

class ChangeOpacityState extends HomeState {}
