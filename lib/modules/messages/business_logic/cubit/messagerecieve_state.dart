part of 'messagerecieve_cubit.dart';

abstract class MessagerecieveState {
  const MessagerecieveState();
}

class MessagerecieveInitial extends MessagerecieveState {}

class MessageRecieveSuccessLoadingState extends MessagerecieveState {}

class MessageRecieveSuccessState extends MessagerecieveState {}

class MessageRecieveErrorState extends MessagerecieveState {
  final Exception error;

  const MessageRecieveErrorState(this.error);
}

class NoAuthState extends MessagerecieveState {}
