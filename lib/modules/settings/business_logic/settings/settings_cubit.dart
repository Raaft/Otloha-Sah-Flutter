import 'package:bloc/bloc.dart';
import 'package:flutter_base/modules/settings/data/models/setting.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());

  changeSetting(List<Settings> settings) {
    emit(SettingsChange(settings: settings));
  }

  changeSettingDwon(List<Settings> settings) {
    emit(SettingsChangeDown(settings: settings));
  }
}
