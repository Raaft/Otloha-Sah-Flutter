// ignore_for_file: non_constant_identifier_names

import 'package:file/src/interface/file.dart';

import 'package:flutter_base/data_source/models/home_models/user_prfile.dart';
import 'package:flutter_base/data_source/models/message_model/reply_request.dart';
import 'package:flutter_base/data_source/remote/messages_service.dart';
import 'package:flutter_base/data_source/remote/profile_services.dart';

import 'repository/auth_repo.dart';

class DataSource {
  final AuthRepository _authRepository = AuthRepository();
  final ProfileServices _profileServices = ProfileServices();
  final GetMessages _getMessages = GetMessages();

  getMessageListing() {
    return _getMessages.getMessageListing();
  }

  messagesSent() {
    return _getMessages.messagesSent();
  }

  messagesRecieve() {
    return _getMessages.messgasRecieve();
  }

  messageDetails({required int messageId}) {
    return _getMessages.messageDetails(messageId: messageId);
  }

  sendMessage({required int messageId}) async {
    return _getMessages.sendMessage(messageId: messageId);
  }

  createMessageReply({
    required int messageId,
    required List<int> verses_ids,
    required File record,
    required String comment,
    required int verseId,
    required int position_from,
    required int positition_to,
    required String error_type,
  }) async {
    return _getMessages.createMessageReply(
        messageId: messageId,
        verses_ids: verses_ids,
        record: record,
        comment: comment,
        verseId: verseId,
        position_from: position_from,
        positition_to: positition_to,
        error_type: error_type);
  }

  addToGeneral(int id) async {
    return _getMessages.addToGeneral(id);
  }

  deleteRecitations(int id) {
    return _getMessages.deleteRecitations(id);
  }

  markAsFinished(int id) async {
    return _getMessages.markAsFinished(id);
  }

  markAsAccepted({required int id, required int messageId}) {
    return _getMessages.markAsAccepted(id: id, messageId: messageId);
  }

  markAsRead({required int id, required int messageId}) {
    return _getMessages.markAsRead(id: id, messageId: messageId);
  }

  markAsRemarkable({required int id, required int messageId}) async {
    return _getMessages.markAsRemarkable(id: id, messageId: messageId);
  }

  replyMessages(ReplyRequest replyRequest) async {
    return _getMessages.replyMessages(replyRequest);
  }

  createMessages(int id) async {
    return _getMessages.createMessages(id);
  }

  sendMessageAsTeacher(int recitationId, int msgId) {
    return _getMessages.sendMessageAsTeacher(recitationId, msgId);
  }

  Future<UserProfile> myProfile() => _profileServices.myProfile();

  Future<UserProfile> userProfile(int id) => _profileServices.myProfile();

  userLogIn({email, password}) =>
      _authRepository.userLogIn(email: email, password: password);

  logOut({String? auth}) => _authRepository.logOut(auth: auth);

  passwordReset({email}) => _authRepository.passwordReset(email: email);

  passwordResetConfirm({uid, token, new_password1, new_password2}) =>
      _authRepository.passwordResetConfirm(
          uid: uid,
          new_password1: new_password1,
          new_password2: new_password2,
          token: token);

  passwordChange({old_password, new_password1, new_password2}) =>
      _authRepository.passwordChange(
          old_password: old_password,
          new_password2: new_password2,
          new_password1: new_password1);

  refreshToken() => _authRepository.refreshToken();

  userRegister(
          {email, username, password1, password2, birthdate, phone, gender}) =>
      _authRepository.userRegister(
          email: email,
          birthdate: birthdate,
          gender: gender,
          password1: password1,
          password2: password2,
          phone: phone,
          username: username);

  getProfile() => _authRepository.getProfile();
}
