import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quran_widget_flutter/data_source/data_source.dart';
import 'package:quran_widget_flutter/model/explanation_model.dart';

part 'tafsir_state.dart';

class TafsirCubit extends Cubit<TafsirState> {
  TafsirCubit() : super(TafsirInitial());


  fetchTafsirList() {
    try {


      DataSource.instance.fetchTafseerList().then((value) async {
        if (value!.isNotEmpty) {
          emit(TafsirFetched(value));
        } else {
          emit(TafsirEmpty(false));
        }
      });
    } catch (e) {
      emit(TafsirError(e.toString()));
    }
  }

}
