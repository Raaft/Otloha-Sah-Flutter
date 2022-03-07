import 'package:bloc/bloc.dart';
import 'package:quran_widget_flutter/quran_widget_flutter.dart';

part 'tajweed_state.dart';

class TajweedCubit extends Cubit<TajweedState> {
  TajweedCubit() : super(TajweedInitial());
}
