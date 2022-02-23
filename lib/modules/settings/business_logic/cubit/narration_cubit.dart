import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_base/core/data/chash_helper.dart';
import 'package:quran_widget_flutter/data_source/data_source.dart';
import 'package:quran_widget_flutter/model/narration.dart';

part 'narration_state.dart';

class NarrationCubit extends Cubit<NarrationState> {
  NarrationCubit() : super(NarrationInitial());

  fetchNarration() {
    try {
      DataSource.instance.fetchNarrationsList().then((value) async {
        if (value!.isNotEmpty) {
          int val =
              (CacheHelper.getData(key: 'NarrationsSelected') as int?) ?? -1;
          value.forEach((element) {
            if (element.id == val) {
              val = value.indexOf(element);
            }
          });
          emit(NarrationFetched(value, val));
        } else {
          emit(const NarrationError('Not Found Data'));
        }
      });
    } catch (e) {
      emit(NarrationError(e.toString()));
    }
  }
}
