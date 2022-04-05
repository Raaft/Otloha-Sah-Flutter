part of 'tafsir_cubit.dart';

@immutable
abstract class TafsirState {}

class TafsirInitial extends TafsirState {}



class TafsirFetched extends TafsirState {
  final List<ExplanationModel> Tafsir;
  TafsirFetched(this.Tafsir);
}

class TafsirError extends TafsirState {
  final String error;
  TafsirError(this.error);
}

class TafsirEmpty extends TafsirState {
  final bool isNarrtion;
  TafsirEmpty(this.isNarrtion);
}