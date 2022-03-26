part of 'userrecitation_cubit.dart';

abstract class UserRecitationState {
  const UserRecitationState();
}

class UserRecitationInitial extends UserRecitationState {}

class UserRecitationFetched extends UserRecitationState {}

class UserRecitationError extends UserRecitationState {}

class UserRecitationLoading extends UserRecitationState {}

class AuthErrorState extends UserRecitationState {}

class RemoveUserRecitationState extends UserRecitationState {}
