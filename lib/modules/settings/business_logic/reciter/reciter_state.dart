part of 'reciter_cubit.dart';

abstract class ReciterState {
  const ReciterState();
}

class ReciterInitial extends ReciterState {}

class ReciterFetched extends ReciterState {
  final List<Reciter> reciters;
  final int selected;
  const ReciterFetched(this.reciters, this.selected);
}

class ReciterError extends ReciterState {
  final String error;
  const ReciterError(this.error);
}
