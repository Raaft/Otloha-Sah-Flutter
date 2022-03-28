import 'package:bloc/bloc.dart';
import 'package:flutter_base/core/data/chash_helper.dart';
import 'package:flutter_base/core/utils/constant/constants.dart';
import 'package:flutter_base/data_source/models/setting_model/init_data.dart';
import 'package:quran_widget_flutter/quran_widget_flutter.dart';

part 'narration_state.dart';

class NarrationCubit extends Cubit<NarrationState> {
  List<Narration>? narrations;
  int? selected;

  NarrationCubit() : super(NarrationInitial());

  changeIndex(int index) {
    selected = index;
    emit(NarrationChangeSelected(narrations!, index));
  }

  fetchNarration({String? qurey}) {
    try {
      DataSource.instance.fetchNarrationsList(qurey: qurey).then((value) async {
        if (value!.isNotEmpty) {
          int val =
              (CacheHelper.getData(key: narrationSelectedId) as int?) ?? -1;
          for (var element in value) {
            if (element.id == val) {
              val = value.indexOf(element);
              settings[0].subTitle = element.name;
              break;
            }
          }
          narrations = value;
          selected = val;
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
