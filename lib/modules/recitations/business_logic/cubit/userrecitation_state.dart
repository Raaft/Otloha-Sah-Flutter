part of 'userrecitation_cubit.dart';

abstract class UserRecitationState {}

class UserRecitationInitial extends UserRecitationState {}

class UserRecitationFetched extends UserRecitationState {}

class UserRecitationError extends UserRecitationState {
  final Exception error;

  UserRecitationError(this.error);
}

class UserRecitationLoading extends UserRecitationState {}

class AuthErrorState extends UserRecitationState {}

class RemoveUserRecitationState extends UserRecitationState {}
