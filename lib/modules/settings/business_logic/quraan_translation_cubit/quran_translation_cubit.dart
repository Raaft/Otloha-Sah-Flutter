import 'package:bloc/bloc.dart';
import 'package:flutter_base/modules/settings/business_logic/quraan_translation_cubit/quran_translation_state.dart';
import 'package:quran_widget_flutter/data_source/data_source.dart';





class QuranTranslationCubit extends Cubit<QuranTranslationState> {
  QuranTranslationCubit() : super(QuranTranslationInitial());

  fetchTranslationList() {
    try {


      DataSource.instance.fetchTranslationList().then((value) async {
        if (value!.isNotEmpty) {
          emit(QuranTranslationFetched(value));
        } else {
          emit(QuranTranslationEmpty(false));
        }
      });
    } catch (e) {
      emit(QuranTranslationError(e.toString()));
    }
  }
}
