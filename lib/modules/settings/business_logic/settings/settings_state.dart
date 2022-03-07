part of 'settings_cubit.dart';

abstract class SettingsState {
  const SettingsState();
}

class SettingsInitial extends SettingsState {}

class SettingsChange extends SettingsState {
  final List<Settings> settings;
  const SettingsChange({
    required this.settings,
  });
}

class SettingsChangeDown extends SettingsState {
  final List<Settings> settings;
  const SettingsChangeDown({
    required this.settings,
  });
}
