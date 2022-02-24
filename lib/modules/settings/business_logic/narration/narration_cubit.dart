import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quran_widget_flutter/model/narration.dart';

part 'narration_state.dart';

class NarrationCubit extends Cubit<NarrationState> {
  NarrationCubit() : super(NarrationInitial());

  fetchNarration() {

  }
}
