import 'package:flutter_base/modules/data/model/recitaion_details.dart';
import 'package:flutter_base/modules/messages/data/models/message_delails.dart';

abstract class MessageRepositroy {
  Future<MessageDelails?> messageDetails(int msgId, int recitationId);
  Future<RecitationDetails?> recitationDetails(int recitationId);
}
