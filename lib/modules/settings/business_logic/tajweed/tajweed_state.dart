part of 'tajweed_cubit.dart';

abstract class TajweedState {
  const TajweedState();
}

class TajweedInitial extends TajweedState {}

class TajweedFetched extends TajweedState {
  final List<Narration> narrations;
  final int selected;
  const TajweedFetched(this.narrations, this.selected);
}

class TajweedError extends TajweedState {
  final String error;
  const TajweedError(this.error);
}
