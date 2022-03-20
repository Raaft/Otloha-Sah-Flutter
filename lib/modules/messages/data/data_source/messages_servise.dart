// ignore_for_file: non_constant_identifier_names, implementation_imports

import 'package:dio/dio.dart';
import 'package:file/src/interface/file.dart';
import 'package:flutter_base/core/network/api_base_helper.dart';
import 'package:flutter_base/modules/messages/data/repositories/messages_repo.dart';

class GetMessages extends MessagesRepository {
  @override
  Future<Response?>? getMessageListing() async {
    try {
      return await ApiBaseHelper().getHTTP('/api/v1/recitations/messages/');
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Future<Response?>? messagesSent() async {
    return await ApiBaseHelper().getHTTP('/api/v1/recitations/messages/sent/');
  }

  @override
  Future<Response?>? messgasRecieve() async {
    return await ApiBaseHelper()
        .getHTTP('/api/v1/recitations/messages/received/');
  }

  @override
  Future<Response?> messageDetails({required int messageId}) async {
    return await ApiBaseHelper()
        .getHTTP('/api/v1/recitations/messages/<$messageId>/');
  }

  @override
  Future<Response?> sendMessage({required int messageId}) async {
    return await ApiBaseHelper()
        .postHTTP('/api/v1/recitations/messages/<$messageId>/', {});
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
  }) async {
    FormData formData = FormData.fromMap({
      'record':
          await MultipartFile.fromFile(record.path, filename: record.basename),
      'FIELD_NAME_WEBSERVICE_HERE': 'sample value for another field',
      'verses_ids': verses_ids,
      'comment': comment,
      'verseId': verseId,
      'position_from': position_from,
      'positition_to': positition_to,
      'error_type': error_type,
    });
    ApiBaseHelper().postHTTP(
        '/api/v1/recitations/messages/<$messageId>/replies/', formData);
    throw UnimplementedError();
  }

  @override
  Future<Response> addToGeneral(int id) async {
    try {
      return await ApiBaseHelper()
          .postHTTP('/api/v1/recitations/$id/add-to-general/', {});
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Future<Response> deleteRecitations(int id) async {
    try {
      return await ApiBaseHelper()
          .deleteHTTP('/api/v1/recitations/$id/delete/');
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Future<Response> markAsFinished(int id) async {
    try {
      return await ApiBaseHelper()
          .postHTTP('/api/v1/recitations/$id/mark-as-finished/', {});
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Future<Response> markAsAccepted() {
    // TODO: implement markAsAccepted
    throw UnimplementedError();
  }

  @override
  Future<Response> markAsRead() {
    // TODO: implement markAsRead
    throw UnimplementedError();
  }

  @override
  Future<Response> markAsRemarkable() {
    // TODO: implement markAsRemarkable
    throw UnimplementedError();
  }


}
