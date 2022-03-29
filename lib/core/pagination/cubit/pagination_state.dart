part of 'pagination_cubit.dart';

abstract class PaginationState {
  const PaginationState();
}

class PaginationInitial extends PaginationState {}

class PaginationFertchedData extends PaginationState {}

class PaginationLoadingData extends PaginationState {}

class PaginationErrorgData extends PaginationState {}
