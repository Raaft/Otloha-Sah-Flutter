abstract class ReplyState {}

class InitialReplyState extends ReplyState {}

class StartRecordingState extends ReplyState {}

class EndRecordingState extends ReplyState {}

class MoveToTrashState extends ReplyState {}

class DeleteRecordState extends ReplyState {}

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
