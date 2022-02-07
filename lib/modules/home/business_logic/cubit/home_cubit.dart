import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  changeIndex(int? index) {
    emit(HomeInitial());
    debugPrint('index $index');
    emit(HomeChangeIndex(index ?? 0));
  }
}
