// ignore_for_file: non_constant_identifier_names, implementation_imports

import 'package:dio/dio.dart';
import 'package:file/src/interface/file.dart';
import 'package:flutter_base/core/network/api_base_helper.dart';
import 'package:flutter_base/modules/messages/data/repositories/messages_repo.dart';

class GetMessages extends MessagesRepository {
  @override
  Future<Response> getMessageListing() {
    ApiBaseHelper().getHTTP('/recitations/messages/');
    throw UnimplementedError();
  }

  @override
  Future<Response> messagesSent() {
    ApiBaseHelper().getHTTP('/recitations/messages/sent/');
    throw UnimplementedError();
  }

  @override
  Future<Response> messgasRecieve() {
    ApiBaseHelper().getHTTP('/recitations/messages/received/');
    throw UnimplementedError();
  }

  @override
  Future<Response> messageDetails({required int messageId}) {
    ApiBaseHelper().getHTTP('/recitations/messages/<$messageId>/');
    throw UnimplementedError();
  }

  @override
  Future<Response> sendMessage({required int messageId}) {
    ApiBaseHelper().postHTTP('/recitations/messages/<$messageId>/', {});
    throw UnimplementedError();
  }

  @override
  Future<Response> createMessageReply({
    required int messageId,
    required List<int> verses_ids,
    required File record,
    required String comment,
    required int verseId,
    required int position_from,
    required int positition_to,
    required String error_type,
  }) async{

    FormData formData = FormData.fromMap({
    'record': await MultipartFile.fromFile(record.path,filename:record.basename),
    'FIELD_NAME_WEBSERVICE_HERE':'sample value for another field',
    'verses_ids':verses_ids,
    'comment':comment,
    'verseId':verseId,
    'position_from':position_from,
    'positition_to':positition_to,
    'error_type':error_type,

    });
    ApiBaseHelper().postHTTP('/recitations/messages/<$messageId>/replies/', formData);
    throw UnimplementedError();
  }
}
