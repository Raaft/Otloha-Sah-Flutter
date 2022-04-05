



import 'package:quran_widget_flutter/model/translation_model.dart';

abstract class QuranTranslationState {}

class QuranTranslationInitial extends QuranTranslationState {}


class QuranTranslationFetched extends QuranTranslationState {
  final List<TranslationModel> translation;
   QuranTranslationFetched(this.translation);
}

class QuranTranslationError extends QuranTranslationState {
  final String error;
   QuranTranslationError(this.error);
}

class QuranTranslationEmpty extends QuranTranslationState {
  final bool isNarrtion;
   QuranTranslationEmpty(this.isNarrtion);
}