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
