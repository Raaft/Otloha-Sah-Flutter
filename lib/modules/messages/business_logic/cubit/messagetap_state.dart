part of 'messagetap_cubit.dart';

abstract class MessageTapState extends Equatable {
  const MessageTapState();

  @override
  List<Object> get props => [];
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
  final String error;

  const MessageErrorState(this.error);
}

class MessageSendSuccessLoadingState extends MessageTapState {}

class MessageSendSuccessState extends MessageTapState {}

class MessageSendErrorState extends MessageTapState {
  final String error;

  const MessageSendErrorState(this.error);
}

class MessageRecieveSuccessLoadingState extends MessageTapState {}

class MessageRecieveSuccessState extends MessageTapState {}

class MessageRecieveErrorState extends MessageTapState {
  final String error;

  const MessageRecieveErrorState(this.error);
}

class MessageDetailsLoadingState extends MessageTapState {}

class MessageDetailsSuccessState extends MessageTapState {}

class MessageDetailsErrorState extends MessageTapState {
  final String error;

  const MessageDetailsErrorState(this.error);
}


class SendMessageLoadingState extends MessageTapState {}

class SendMessageSuccessState extends MessageTapState {}

class SendMessageErrorState extends MessageTapState {
  final String error;

  const SendMessageErrorState(this.error);
}