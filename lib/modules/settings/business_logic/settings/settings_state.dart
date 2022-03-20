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



class UpdatePhoneLoadingState extends SettingsState {}


class UpdatePhoneSuccessState extends SettingsState {
  UpdatePhoneSuccessState(Response value);
}

class UpdatePhoneErrorState extends SettingsState {
  final String error;

  const UpdatePhoneErrorState(this.error);
}


class UpdateEmailLoadingState extends SettingsState {}

class UpdateEmailSuccessState extends SettingsState {
  UpdateEmailSuccessState(Response value);
}

class UpdateEmailErrorState extends SettingsState {
  final String error;

  const UpdateEmailErrorState(this.error);
}
class RegisterAsTeacherLoadingState extends SettingsState {}

class RegisterAsTeacherSuccessState extends SettingsState {
  RegisterAsTeacherSuccessState(Response value);
}

class RegisterAsTeacherErrorState extends SettingsState {
  final String error;

  const RegisterAsTeacherErrorState(this.error);
}

class ChangePasswordLoadingState extends SettingsState {}


class ChangePasswordSuccessState extends SettingsState {
  ChangePasswordSuccessState(Response value);
}

class ChangePasswordErrorState extends SettingsState {
  final String error;

  const ChangePasswordErrorState(this.error);
}

