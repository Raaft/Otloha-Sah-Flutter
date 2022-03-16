part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class LogInLoadingState extends AuthState {}

class LogInSuccessState extends AuthState {}

class LogInErrorState extends AuthState {
  final String error;

  LogInErrorState(this.error);
}

class LogOutLoadingState extends AuthState {}

class LogOutSuccessState extends AuthState {}

class LogOutErrorState extends AuthState {
  final String error;

  LogOutErrorState(this.error);
}

class RegisterLoadingState extends AuthState {}

class RegisterSuccessState extends AuthState {}

class RegisterErrorState extends AuthState {
  final String error;

  RegisterErrorState(this.error);
}
