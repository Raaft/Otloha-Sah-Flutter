import 'package:flutter_base/core/network/api_base_helper.dart';
import 'package:flutter_base/modules/data/data_source/remote/repositories/message_repositroy.dart';
import 'package:flutter_base/modules/messages/data/models/message_delails.dart';

class MessageApi extends MessageRepositroy {
  @override
  Future<MessageDelails?> messageDetails(int msgId, int recitationId) async {
    print('msg $msgId rcitation $recitationId');
    await ApiBaseHelper()
        .getHTTP('/api/v1/recitations/$recitationId/messages/$msgId/')
        .then((value) {
      print('msg $value');
      return MessageDelails.fromJson(value!.data);
    });
  }
}
