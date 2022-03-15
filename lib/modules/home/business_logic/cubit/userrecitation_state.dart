part of 'userrecitation_cubit.dart';

abstract class UserRecitationState extends Equatable {
  const UserRecitationState();

  @override
  List<Object> get props => [];
}

class UserRecitationInitial extends UserRecitationState {}

class UserRecitationFetched extends UserRecitationState {}

class UserRecitationError extends UserRecitationState {}

class UserRecitationLoading extends UserRecitationState {}
