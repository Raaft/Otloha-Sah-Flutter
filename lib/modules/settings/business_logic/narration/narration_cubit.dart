import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_base/core/data/chash_helper.dart';
import 'package:flutter_base/modules/settings/data/models/init_data.dart';
import 'package:quran_widget_flutter/data_source/data_source.dart';
import 'package:quran_widget_flutter/model/narration.dart';

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
              (CacheHelper.getData(key: 'NarrationsSelected') as int?) ?? -1;
          for (var element in value) {
            if (element.id == val) {
              val = value.indexOf(element);
              settings[0].subTitle = element.name;
              break;
            }
          }
          narrations = value;
          selected = val;
          emit(NarrationInitial());
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
