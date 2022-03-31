import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_widget_flutter/quran_widget_flutter.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  bool isFloatingMenu = false;
  double opacity = 0.0;

  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of<HomeCubit>(context);

  changeIndex(int? index) {
    debugPrint('index $index');
    emit(HomeChangeIndex(index ?? 0));
  }

  PageType pageType = PageType.quran;

  Future<void> changePluginPage({required PageType page}) async {
    print('page type = $page');
    pageType = page;
    emit(ChangePageState());
  }

  changeIsOnTruePressed() {
    isFloatingMenu = false;

    emit(ChangePageFalseState());
  }

  changeTrueFloating() {
    isFloatingMenu = true;
    emit(IsFloatingTrueMenuState());
  }

  changeIsOnFalsePressed() {
    emit(ChangePageFalseState());
  }

  // changeOpacity(double myOpacity) {
  //   opacity = myOpacity;
  //   emit(ChangeOpacityState());
  // }
}
