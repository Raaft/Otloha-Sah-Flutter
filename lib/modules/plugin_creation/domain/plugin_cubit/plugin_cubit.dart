import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:quran_widget_flutter/quran_widget_flutter.dart';

part 'plugin_state.dart';

class PluginCubit extends Cubit<PluginState> {
  PluginCubit() : super(PluginInitial());

  PluginCubit get(context) => BlocProvider.of(context);

  PageType pageType=PageType.quran;

  void changePage({required PageType page}) {
    print('page type = $page');
    pageType = page;
    emit(ChangePageState());
  }
}
