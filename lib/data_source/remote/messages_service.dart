// ignore_for_file: non_constant_identifier_names, implementation_imports

import 'package:dio/dio.dart';
import 'package:file/src/interface/file.dart';
import 'package:flutter_base/core/network/api_base_helper.dart';
import 'package:flutter_base/core/widgets/toasts.dart';
import 'package:flutter_base/data_source/models/message_model/reply_request.dart';




class GetMessages {

  Future<Response?> getMessageListing() async {
    try {
      return await ApiBaseHelper().getHTTP('/api/v1/recitations/messages/');
    } catch (e) {
      throw UnimplementedError();
    }
  }


  Future<Response?> messagesSent() async {
    return await ApiBaseHelper().getHTTP('/api/v1/recitations/messages/sent/');
  }


  Future<Response?>? messgasRecieve() async {
    return await ApiBaseHelper()
        .getHTTP('/api/v1/recitations/messages/received/');
  }


  Future<Response?> messageDetails({required int messageId}) async {
    return await ApiBaseHelper()
        .getHTTP('/api/v1/recitations/messages/<$messageId>/');
  }


  Future<Response?> sendMessage({required int messageId}) async {
    return await ApiBaseHelper()
        .postHTTP('/api/v1/recitations/messages/<$messageId>/', {});
  }


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


  Future<Response> addToGeneral(int id) async {
    Response response = await ApiBaseHelper()
        .postHTTP('/api/v1/recitations/$id/add-to-general/', {});
    SuccessToast.toast(response.data['message']);
    return response;
  }


  Future<Response> deleteRecitations(int id) async {
    Response response =
        await ApiBaseHelper().deleteHTTP('/api/v1/recitations/$id/delete/');

    return response;
  }


  Future<Response> markAsFinished(int id) async {
    Response response = await ApiBaseHelper()
        .postHTTP('/api/v1/recitations/$id/mark-as-finished/', {});
    SuccessToast.toast(response.data['message']);
    return response;
  }


  Future<Response> markAsAccepted(
      {required int id, required int messageId}) async {
    Response response = await ApiBaseHelper().postHTTP(
        '/api/v1/recitations/$id/messages/$messageId/mark-as-accepted/', {});
    SuccessToast.toast(response.data['message']);
    return response;
  }


  Future<Response> markAsRead({required int id, required int messageId}) async {
    Response response = await ApiBaseHelper().postHTTP(
        '/api/v1/recitations/$id/messages/$messageId/mark-as-read/', {});
    SuccessToast.toast(response.data['message']);
    return response;
  }


  Future<Response> markAsRemarkable(
      {required int id, required int messageId}) async {
    Response response = await ApiBaseHelper().postHTTP(
        '/api/v1/recitations/$id/messages/$messageId/mark-as-remarkable/', {});
    SuccessToast.toast(response.data['message']);
    return response;
  }


  Future<Response>? replyMessages(ReplyRequest replyRequest) async {
    return ApiBaseHelper().postPhotoHTTP(
        '/api/v1/recitations/${replyRequest.recitationId}/messages/${replyRequest.messageId}/replies/',
        await replyRequest.toMap());
  }


  Future<Response>? createMessages(int id) async {
    Response response = await ApiBaseHelper()
        .postHTTP('/api/v1/recitations/$id/messages/create/', {});
    return response;
  }


  Future<Response>? sendMessageAsTeacher(int recitationId, int msgId) async {
    Response? response = await ApiBaseHelper().postHTTP(
        '/api/v1/recitations/$recitationId/messages/$msgId/send/', {});
    SuccessToast.toast(response.data['message']);
    return response;
  }
}
