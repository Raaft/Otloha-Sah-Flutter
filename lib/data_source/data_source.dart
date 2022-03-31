import 'package:dio/dio.dart';
import 'package:file/file.dart';
import 'package:flutter_base/data_source/models/database_model/teacher_response_entity.dart';
import 'local/database/database_repository.dart';

import 'models/home_models/user_profile.dart';
import 'models/message_model/reply_request.dart';
import 'remote/recitation_services.dart';
import 'remote/messages_service.dart';
import 'remote/user_services.dart';

import 'remote/auth_services.dart';

class AppDataSource {
  final AuthApi _authApi = AuthApi();
  final UserServices _userServices = UserServices();
  final GetMessages _getMessages = GetMessages();
  final DatabaseRepository _databaseRepository = DatabaseRepository();
  final UserRecitationApi _userRecitationApi = UserRecitationApi();

  saveUserReciataion({required userRecitation}) =>
      _userRecitationApi.saveUserReciataion(userRecitation: userRecitation);

  getUserReciataions(int page) => _userRecitationApi.getUserReciataions(page);

  getGeneraBoXMessage() => _userRecitationApi.getGeneraBoXMessage();

  getRecitationTeacher() => _userRecitationApi.getTeacher();

  Future<List<TeacherResponse>?>? getTeacher(int page) =>
      _userServices.getTeacher(page);

  Future<List<TeacherResponse>?> getStudents(int nextLink) =>
      _userServices.getStudents(nextLink);

  Future<String?>? sendMessage(int id, List<int> users) =>
      _userServices.sendMessage(id, users);

  recitationDetails(int recitationId) =>
      _userRecitationApi.recitationDetails(recitationId);

  // Verse Liked

  findAllVerseLikeds() => _databaseRepository.findAllVerseLikeds();

  findVerseLikedById(int id) => _databaseRepository.findVerseLikedById(id);

  insertVerseLiked(verseLiked) =>
      _databaseRepository.insertVerseLiked(verseLiked);

  updateVerseLiked(verseLiked) =>
      _databaseRepository.updateVerseLiked(verseLiked);

  deleteVerseLiked(int id) => _databaseRepository.deleteVerseLiked(id);

  // Verse Note
  findAllVerseNotes() => _databaseRepository.findAllVerseNotes();

  findVerseNoteById(int id) => _databaseRepository.findVerseNoteById(id);

  insertVerseNote(verseNote) => _databaseRepository.insertVerseNote(verseNote);

  updateVerseNote(verseNote) => _databaseRepository.updateVerseNote(verseNote);

  deleteVerseNote(int id) => _databaseRepository.deleteVerseNote(id);

  // Page Marked
  findAllPageMarkeds() => _databaseRepository.findAllPageMarkeds();

  findPageMarkedById(int id) => _databaseRepository.findPageMarkedById(id);

  insertPageMarked(pageMarked) =>
      _databaseRepository.insertPageMarked(pageMarked);

  updatePageMarked(pageMarked) =>
      _databaseRepository.updatePageMarked(pageMarked);

  deletePageMarked(int id) => _databaseRepository.deletePageMarked(id);

  markAsFavTeacher({required int? id}) async {
    return _userServices.markAsFavTeacher(id: id);
  }

  changePassword(
      {required oldPassword, required newPassword, required confirmPassword}) {
    return _userServices.changePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword);
  }

  updateEmail({required email, required password}) {
    return _userServices.updateEmail(email: email, password: password);
  }

  updatePhone({required phone, required password}) {
    return _userServices.updatePhone(phone: phone, password: password);
  }

  updateProfile({required email, required password}) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }

  registerAsATeacher(data) {
    return _userServices.registerAsATeacher(data);
  }

  getMessageListing() {
    return _getMessages.getMessageListing();
  }

  messagesSent() {
    return _getMessages.messagesSent();
  }

  messagesRecieve() {
    return _getMessages.messgasRecieve();
  }

  Future<Response<dynamic>?> messageDetails(
      {required int messageId, required int recitationId}) {
    return _getMessages.messageDetails(
        messageId: messageId, recitationId: recitationId);
  }

  sendRecitationsMessage({required int messageId}) async {
    return _getMessages.sendMessage(messageId: messageId);
  }

  createMessageReply({
    required int messageId,
    required List<int> versesIds,
    required File record,
    required String comment,
    required int verseId,
    required int positionFrom,
    required int positionTo,
    required String errorType,
  }) async {
    return _getMessages.createMessageReply(
        messageId: messageId,
        verses_ids: versesIds,
        record: record,
        comment: comment,
        verseId: verseId,
        position_from: positionFrom,
        positition_to: positionTo,
        error_type: errorType);
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

  Future<UserProfile> myProfile() => _userServices.myProfile();

  Future<UserProfile> userProfile(int id) => _userServices.myProfile();

  userLogIn({email, password}) =>
      _authApi.userLogIn(email: email, password: password);

  logOut({String? auth}) => _authApi.logOut(auth: auth);

  passwordReset({email}) => _authApi.passwordReset(email: email);

  passwordResetConfirm({uid, token, newPassword1, newPassword2}) =>
      _authApi.passwordResetConfirm(
          uid: uid,
          new_password1: newPassword1,
          new_password2: newPassword2,
          token: token);

  passwordChange({oldPassword, newPassword1, newPassword2}) =>
      _authApi.passwordChange(
          old_password: oldPassword,
          new_password2: newPassword2,
          new_password1: newPassword1);

  refreshToken() => _authApi.refreshToken();

  userRegister(
          {email, username, password1, password2, birthdate, phone, gender}) =>
      _authApi.userRegister(
          email: email,
          birthdate: birthdate,
          gender: gender,
          password1: password1,
          password2: password2,
          phone: phone,
          username: username);

  getProfile() => _authApi.getProfile();
}
