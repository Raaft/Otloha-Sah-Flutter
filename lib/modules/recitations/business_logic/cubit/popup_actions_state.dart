import 'package:flutter_base/modules/data/model/recitations.dart';

abstract class PopupActionsState {}

class PopupInitialState extends PopupActionsState {}

class MarkAsFinishedState extends PopupActionsState {}

class AddToGeneralState extends PopupActionsState {}

class RemoveRecitationState extends PopupActionsState {
  final Recitations userRecitatios;
  RemoveRecitationState(this.userRecitatios);
}

class MarkAsAcceptedState extends PopupActionsState {}

class MarkAsRemarkableState extends PopupActionsState {}

class MarkAsReadState extends PopupActionsState {}
