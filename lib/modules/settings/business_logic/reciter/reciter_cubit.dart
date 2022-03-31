import 'package:bloc/bloc.dart';
import '../../../../data_source/cache_helper.dart';
import '../../../../core/utils/constant/constants.dart';
import '../../../../data_source/models/setting_model/init_data.dart';
import 'package:quran_widget_flutter/quran_widget_flutter.dart';

part 'reciter_state.dart';

class ReciterCubit extends Cubit<ReciterState> {
  ReciterCubit() : super(ReciterInitial());

  fetchReciter({String? qurey}) {
    int narration = CacheHelper.getData(key: narrationSelectedId) ?? 0;
    int val = (CacheHelper.getData(key: reciterSelectedId) as int?) ?? 0;

    List<Reciter> recitersView = [];

    try {
      DataSource.instance
          .fetchRecitersList(qurey: qurey)
          .then((reciters) async {
        if (reciters!.isNotEmpty) {
          DataSource.instance
              .fetchRecitationsList(narrationId: narration)
              .then((value) {
            if (val > reciters.length) {
              val = 0;
            }

            if (value != null && value.isNotEmpty) {
              for (var element in value) {
                for (var elementR in reciters) {
                  if (elementR.id == element.reciterId) {
                    recitersView.add(elementR);
                    break;
                  }
                }
              }

              if (recitersView.isNotEmpty) {
                for (var element in recitersView) {
                  if (element.id == val) {
                    val = reciters.indexOf(element);
                    settings[1].subTitle = element.name;
                    break;
                  }
                }

                emit(ReciterFetched(recitersView, val));
              } else {
                emit(const ReciterError('Not Found Data'));
              }
            } else {
              emit(const ReciterError('Not Found Data'));
            }
          });
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
