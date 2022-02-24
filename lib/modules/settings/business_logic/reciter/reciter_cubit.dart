import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:quran_widget_flutter/model/reciter.dart';

part 'reciter_state.dart';

class ReciterCubit extends Cubit<ReciterState> {
  ReciterCubit() : super(ReciterInitial());

  fetchReciter() {}
}
