import 'package:flutter_base/core/network/api_base_helper.dart';
import 'package:flutter_base/data_source/models/database_model/recitaion_details.dart';

class MessageApi {
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
