part of 'tajweed_cubit.dart';

abstract class TajweedState {
  const TajweedState();
}

class TajweedInitial extends TajweedState {}
//
// class TajweedFetched extends TajweedState {
//   final List<Narration> narrations;
//   final int selected;
//   const TajweedFetched(this.narrations, this.selected);
// }
//
// class TajweedError extends TajweedState {
//   final String error;
//   const TajweedError(this.error);
// }




class TajweedFetched extends TajweedState {
  final List<TajweedModel> tajweed;
  TajweedFetched(this.tajweed);
}

class TajweedError extends TajweedState {
  final String error;
  TajweedError(this.error);
}

class TajweedEmpty extends TajweedState {
  final bool isNarrtion;
  TajweedEmpty(this.isNarrtion);
}
