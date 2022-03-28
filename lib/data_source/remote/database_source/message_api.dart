import 'package:flutter_base/core/network/api_base_helper.dart';
import 'package:flutter_base/modules/data/data_source/remote/repositories/message_repositroy.dart';
import 'package:flutter_base/modules/data/model/recitaion_details.dart';

import '../../../../../data_source/models/message_model/message_delails.dart';

class MessageApi extends MessageRepositroy {
  @override
  Future<MessageDelails?> messageDetails(int msgId, int recitationId) async {
    print('msg $msgId rcitation $recitationId');
    var value = await ApiBaseHelper()
        .getHTTP('/api/v1/recitations/$recitationId/messages/$msgId/');
    print('msg $value');
    MessageDelails msg = MessageDelails.fromJson(value!.data);
    print('msg ' + msg.recitation!.name.toString());
    return msg;
  }

  @override
  Future<RecitationDetails?> recitationDetails(int recitationId) async {
    print('rcitation $recitationId');
    var value =
        await ApiBaseHelper().getHTTP('/api/v1/recitations/$recitationId');
    print('msg $value');
    RecitationDetails msg = RecitationDetails.fromJson(value!.data);
    print('msg ' + msg.name.toString());
    return msg;
  }
}
