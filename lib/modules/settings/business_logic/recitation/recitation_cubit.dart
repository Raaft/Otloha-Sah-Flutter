import 'package:bloc/bloc.dart';
import 'package:flutter_base/data_source/cache_helper.dart';
import 'package:flutter_base/core/utils/constant/constants.dart';
import 'package:flutter_base/modules/settings/business_logic/recitation/recitation_state.dart';
import 'package:quran_widget_flutter/data_source/data_source.dart';

class RecitationCubit extends Cubit<RecitationState> {
  RecitationCubit() : super(RecitationInitState());

  fetchRecitations() {
    int narration = CacheHelper.getData(key: narrationSelectedId);
    int reciter = CacheHelper.getData(key: reciterSelectedId);

    try {
      DataSource.instance
          .fetchRecitationsList(narrationId: narration, reciterId: reciter)
          .then((recitations) {
        if (recitations != null && recitations.isNotEmpty) {
          emit(RecitationFetched(recitations));
          CacheHelper.saveData(
                  key: recitationSelectedId, value: recitations.first.id)
              .then((value) {
            emit(RecitationSelectedState(recitations.first));
          });
        } else {
          emit(const RecitationError('No data found'));
        }
      });
    } catch (e) {
      print(e.toString());
      emit(RecitationError(e.toString()));
    }
  }
}
