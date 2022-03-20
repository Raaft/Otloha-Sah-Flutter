// ignore_for_file: non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:file/file.dart';

abstract class MessagesRepository {
  Future<Response?>? getMessageListing();

  Future<Response?>? messgasRecieve();

  Future<Response?>? messagesSent();

  Future<Response?> messageDetails({required int messageId});

  Future<Response?> sendMessage({required int messageId});
  Future<Response?> markAsFinished(int id);
  Future<Response?> addToGeneral(int id);
  Future<Response?> deleteRecitations(int id);

  Future<Response> createMessageReply({
    required int messageId,
    required List<int> verses_ids,
    required File record,
    required String comment,
    required int verseId,
    required int position_from,
    required int positition_to,
    required String error_type,
  });


  Future<Response> markAsRead();
  Future<Response> markAsAccepted();
  Future<Response> markAsRemarkable();

}
