abstract class ReplyState {}

class InitialReplyState extends ReplyState {}

class ReplyStateDefult extends ReplyState {}

class StartRecordingState extends ReplyState {
  final String time;
  StartRecordingState({
    required this.time,
  });
}

class EndRecordingState extends ReplyState {}

class MoveToTrashState extends ReplyState {}

class DeleteRecordState extends ReplyState {}

class SavedState extends ReplyState {}

class DataChange extends ReplyState {}

class SavedErrorState extends ReplyState {}

class ChangeIsReply extends ReplyState {}

class SendReplyState extends ReplyState {
  String text;
  String recordFile;
  String mistakeType;

  SendReplyState({
    required this.mistakeType,
    required this.recordFile,
    required this.text,
  });
}
