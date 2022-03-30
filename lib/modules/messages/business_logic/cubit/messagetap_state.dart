part of 'messagetap_cubit.dart';

abstract class MessageTapState {
  const MessageTapState();
}

class MessageTapInitial extends MessageTapState {}

class MessageTapChange extends MessageTapState {
  final int index;

  const MessageTapChange({
    required this.index,
  });
}

class MessageLoadingState extends MessageTapState {}

class MessageSuccessState extends MessageTapState {}

class MessageErrorState extends MessageTapState {
  final Exception error;

  const MessageErrorState(this.error);
}

class MessageSendSuccessLoadingState extends MessageTapState {}

class MessageSendSuccessState extends MessageTapState {}

class MessageSendErrorState extends MessageTapState {
  final Exception error;

  const MessageSendErrorState(this.error);
}

class MessageRecieveSuccessLoadingState extends MessageTapState {}

class MessageRecieveSuccessState extends MessageTapState {}

class MessageRecieveErrorState extends MessageTapState {
  final Exception error;

  const MessageRecieveErrorState(this.error);
}

class MessageDetailsLoadingState extends MessageTapState {}

class MessageDetailsSuccessState extends MessageTapState {}

class MessageDetailsErrorState extends MessageTapState {
  final Exception error;

  const MessageDetailsErrorState(this.error);
}

class SendMessageLoadingState extends MessageTapState {}

class SendMessageSuccessState extends MessageTapState {}

class SendMessageErrorState extends MessageTapState {
  final Exception error;

  const SendMessageErrorState(this.error);
}

class MarkAsAcceptLoadingState extends MessageTapState {}

class MarkAsAcceptSuccessState extends MessageTapState {}

class MarkAsAcceptErrorState extends MessageTapState {
  final String error;

  const MarkAsAcceptErrorState(this.error);
}

class MarkAsReadLoadingState extends MessageTapState {}

class MarkAsReadSuccessState extends MessageTapState {}

class MarkAsReadErrorState extends MessageTapState {
  final String error;

  const MarkAsReadErrorState(this.error);
}

class MarkAsRemarkableLoadingState extends MessageTapState {}

class MarkAsRemarkableSuccessState extends MessageTapState {}

class MarkAsRemarkableErrorState extends MessageTapState {
  final String error;

  const MarkAsRemarkableErrorState(this.error);
}

class NoAuthState extends MessageTapState {}

class GenaralLoadingState extends MessageTapState {}

class GenaralSuccessState extends MessageTapState {}

class GenaralErrorState extends MessageTapState {
  final Exception error;

  const GenaralErrorState(this.error);
}
