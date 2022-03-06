import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quran_widget_flutter/data_source/data_source.dart';
import 'package:quran_widget_flutter/model/part.dart';

part 'part_state.dart';

class PartCubit extends Cubit<PartState> {
  PartCubit() : super(PartInitial());

  List<Part> parts = [];

  fetchReciter({String? qurey}) {
    try {
      DataSource.instance.fetchPartsList().then((value) async {
        if (value!.isNotEmpty) {
          parts = value;
          emit(PartsFetched());
        } else {
          emit(PartsError());
        }
      });
    } catch (e) {
      print(e.toString());
      emit(PartsError());
    }
  }
}
