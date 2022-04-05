import 'package:bloc/bloc.dart';
import 'package:quran_widget_flutter/model/tajweed_model.dart';
import 'package:quran_widget_flutter/quran_widget_flutter.dart';

part 'tajweed_state.dart';

class TajweedCubit extends Cubit<TajweedState> {
  TajweedCubit() : super(TajweedInitial());
  fetchTajweedList() {
    try {


      DataSource.instance.fetchTajweedList().then((value) async {
        if (value!.isNotEmpty) {
          emit(TajweedFetched(value));
        } else {
          emit(TajweedEmpty(false));
        }
      });
    } catch (e) {
      emit(TajweedError(e.toString()));
    }
  }

}
