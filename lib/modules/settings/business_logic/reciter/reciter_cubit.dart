import 'package:bloc/bloc.dart';
import 'package:flutter_base/core/data/chash_helper.dart';
import 'package:flutter_base/modules/settings/data/models/init_data.dart';
import 'package:quran_widget_flutter/quran_widget_flutter.dart';

part 'reciter_state.dart';

class ReciterCubit extends Cubit<ReciterState> {
  ReciterCubit() : super(ReciterInitial());

  fetchReciter({String? qurey}) {
    try {
      DataSource.instance.fetchRecitersList(qurey: qurey).then((value) async {
        if (value!.isNotEmpty) {
          int val = (CacheHelper.getData(key: 'RecitersSelected') as int?) ?? 0;

          if (val > value.length) {
            val = 0;
          }

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
      print(e.toString());
      emit(ReciterError(e.toString()));
    }
  }
}
