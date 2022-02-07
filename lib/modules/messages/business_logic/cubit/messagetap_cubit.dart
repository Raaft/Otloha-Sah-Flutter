import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'messagetap_state.dart';

class MessageTapCubit extends Cubit<MessageTapState> {
  MessageTapCubit() : super(MessageTapInitial());

  changeIndex(int index) {
    emit(MessageTapInitial());
    emit(MessageTapChange(index: index));
  }
}
