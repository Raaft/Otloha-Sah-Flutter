part of 'messagesend_cubit.dart';

abstract class MessagesendState {
  const MessagesendState();
}

class MessagesendInitial extends MessagesendState {}

class MessageSendSuccessLoadingState extends MessagesendState {}

class MessageSendSuccessState extends MessagesendState {}

class MessageSendErrorState extends MessagesendState {
  final Exception error;

  const MessageSendErrorState(this.error);
}

class NoAuthState extends MessagesendState {}
