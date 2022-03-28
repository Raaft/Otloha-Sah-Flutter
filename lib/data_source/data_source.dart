// ignore_for_file: non_constant_identifier_names

import 'package:file/src/interface/file.dart';
import 'package:flutter_base/data_source/local/database/database_repository.dart';
import 'package:flutter_base/data_source/models/database_model/page_marked.dart';
import 'package:flutter_base/data_source/models/database_model/recitaion_details.dart';
import 'package:flutter_base/data_source/models/database_model/user_recitation.dart';
import 'package:flutter_base/data_source/models/database_model/verse_like.dart';
import 'package:flutter_base/data_source/models/database_model/verse_note.dart';

import 'package:flutter_base/data_source/models/home_models/user_prfile.dart';
import 'package:flutter_base/data_source/models/message_model/message_delails.dart';
import 'package:flutter_base/data_source/models/message_model/reply_request.dart';
import 'package:flutter_base/data_source/remote/database_source/message_api.dart';
import 'package:flutter_base/data_source/remote/database_source/user_api.dart';
import 'package:flutter_base/data_source/remote/database_source/user_recitation_api.dart';
import 'package:flutter_base/data_source/remote/messages_service.dart';
import 'package:flutter_base/data_source/remote/profile_services.dart';
import 'package:flutter_base/data_source/remote/teacher_servises.dart';
import 'package:flutter_base/data_source/remote/update_profile_web_servises.dart';

import 'remote/auth_services.dart';

class AppDataSource {
  final AuthApi _authApi = AuthApi();
  final ProfileServices _profileServices = ProfileServices();
  final GetMessages _getMessages = GetMessages();
  final UpdateProfile _updateProfile = UpdateProfile();
  final TeacherDataService _teacherDataService = TeacherDataService();
  final DatabaseRepository _databaseRepository = DatabaseRepository();
  final MessageApi _messageApi = MessageApi();
  final UserApi _userApi = UserApi();
  final UserRecitationApi _userRecitationApi = UserRecitationApi();

  saveUserReciataion(
      {required  userRecitation}) =>_userRecitationApi.saveUserReciataion(userRecitation: userRecitation);


   getUserReciataions()  =>_userRecitationApi.getUserReciataions();


   getGeneraBoXMessage()  =>_userRecitationApi.getGeneraBoXMessage();

   getRecitationTeacher()  =>_userRecitationApi.getTeacher();

 getTeacher()  => _userApi.getTeacher();


   getStudents()  => _userApi.getStudents();


   sendMessage(int id, List<int> users) => _userApi.sendMessage(id, users);

   messageRecitationDetails(int msgId, int recitationId)  => _messageApi.messageDetails(msgId, recitationId);


   recitationDetails(int recitationId)  => _messageApi.recitationDetails(recitationId);



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
    return _teacherDataService.markAsFavTeacher(id: id);
  }

  changePassword(
      {required oldPassword, required newPassword, required confirmPassword}) {
    return _updateProfile.changePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword);
  }

  updateEmail({required email, required password}) {
    return _updateProfile.updateEmail(email: email, password: password);
  }

  updatePhone({required phone, required password}) {
    return _updateProfile.updatePhone(phone: phone, password: password);
  }

  updateProfile({required email, required password}) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }

  registerAsATeacher(data) {
    return _updateProfile.registerAsATeacher(data);
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

  messageDetails({required int messageId}) {
    return _getMessages.messageDetails(messageId: messageId);
  }

  sendRecitationsMessage({required int messageId}) async {
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
      _authApi.userLogIn(email: email, password: password);

  logOut({String? auth}) => _authApi.logOut(auth: auth);

  passwordReset({email}) => _authApi.passwordReset(email: email);

  passwordResetConfirm({uid, token, new_password1, new_password2}) =>
      _authApi.passwordResetConfirm(
          uid: uid,
          new_password1: new_password1,
          new_password2: new_password2,
          token: token);

  passwordChange({old_password, new_password1, new_password2}) =>
      _authApi.passwordChange(
          old_password: old_password,
          new_password2: new_password2,
          new_password1: new_password1);

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
