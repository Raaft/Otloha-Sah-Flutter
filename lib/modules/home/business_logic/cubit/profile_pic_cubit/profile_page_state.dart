part of 'profile_page_cubit.dart';

@immutable
abstract class ProfilePageState {}

class ProfilePageInitial extends ProfilePageState {}
class GetProfilePageLoading extends ProfilePageState {}
class GetProfilePageSuccess extends ProfilePageState {}
class GetProfilePageError extends ProfilePageState {}
class NoAuthState extends ProfilePageState {}

