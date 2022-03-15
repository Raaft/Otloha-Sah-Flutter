import 'package:quran_widget_flutter/quran_widget_flutter.dart';

abstract class RecitationState {
  const RecitationState();
}

class RecitationInitState extends RecitationState {}

class RecitationFetched extends RecitationState {
  final List<Recitation> recitations;
  const RecitationFetched(this.recitations);
}

class RecitationSelectedState extends RecitationState {
  final Recitation recitation;
  const RecitationSelectedState(this.recitation);
}

class RecitationError extends RecitationState {
  final String error;
  const RecitationError(this.error);
}
