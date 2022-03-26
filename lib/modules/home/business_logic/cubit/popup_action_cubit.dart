import 'package:dio/dio.dart' as dio;
import 'package:flutter_base/core/error/exceptions.dart';
import 'package:flutter_base/core/widgets/toasts.dart';
import 'package:flutter_base/modules/data/data_source/remote/data_source/user_recitation_api.dart';
import 'package:flutter_base/modules/data/model/recitations.dart';
import 'package:flutter_base/modules/home/business_logic/cubit/popup_actions_state.dart';
import 'package:flutter_base/modules/messages/data/data_source/messages_servise.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class PopupActionsCubit extends Cubit<PopupActionsState> {
  PopupActionsCubit() : super(PopupInitialState());

  bool isShared = false;

  setShared(isShared) {
    this.isShared = isShared;
  }

  Future<void> markAsFinished(int id) async {
    await GetMessages().markAsFinished(id);
    Get.back();
    emit(MarkAsFinishedState());
  }

  Future<void> addToGeneral(int id) async {
    try {
      await GetMessages().addToGeneral(id);
      isShared = !isShared;
      emit(AddToGeneralState());
    } on InvalidData catch (e) {
      ErrorToast.toast(e.msg ?? '');
    }
  }

  Future<void> deleteRecitations(int id) async {
    await GetMessages().deleteRecitations(id);
    Get.back();
  }

  Future<void> markAsRemarkable(int id, int messageId) async {
    await GetMessages().markAsRemarkable(id: id, messageId: messageId);
    Get.back();
  }

  Future<void> markAsRead(int id, int messageId) async {
    await GetMessages().markAsRead(id: id, messageId: messageId);
    Get.back();
  }

  Future<void> markAsAccepted(int id, int messageId) async {
    await GetMessages().markAsAccepted(id: id, messageId: messageId);
    Get.back();
  }

  Future<int> createMessage(int id) async {
    dio.Response? response = await GetMessages().createMessages(id);
    Get.back();
    return response!.data['id'];
  }
}
