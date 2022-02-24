import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quran_widget_flutter/model/narration.dart';

part 'tajweed_state.dart';

class TajweedCubit extends Cubit<TajweedState> {
  TajweedCubit() : super(TajweedInitial());
}
