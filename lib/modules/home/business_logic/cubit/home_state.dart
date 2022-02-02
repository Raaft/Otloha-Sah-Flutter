part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeIndex extends HomeState {
  final BottomBarData item;
  final int index;

  const HomeIndex(this.item, this.index);
}
