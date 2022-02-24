import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_base/core/data/chash_helper.dart';
import 'package:flutter_base/modules/settings/data/models/init_data.dart';
import 'package:quran_widget_flutter/data_source/data_source.dart';
import 'package:quran_widget_flutter/model/reciter.dart';

part 'reciter_state.dart';

class ReciterCubit extends Cubit<ReciterState> {
  ReciterCubit() : super(ReciterInitial());

  fetchReciter() {
    try {
      DataSource.instance.fetchRecitersList().then((value) async {
        if (value!.isNotEmpty) {
          int val =
              (CacheHelper.getData(key: 'RecitersSelected') as int?) ?? -1;
          for (var element in value) {
            if (element.id == val) {
              val = value.indexOf(element);
              settings[1].subTitle = element.name;
              break;
            }
          }
          emit(ReciterFetched(value, val));
        } else {
          emit(const ReciterError('Not Found Data'));
        }
      });
    } catch (e) {
      emit(ReciterError(e.toString()));
    }
  }
}
