part of 'part_cubit.dart';

@immutable
abstract class PartState {}

class PartInitial extends PartState {}
class PartsFetched extends PartState {}
class PartsError extends PartState {}
