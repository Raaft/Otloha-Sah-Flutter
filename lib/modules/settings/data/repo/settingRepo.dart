import 'package:dio/dio.dart';

abstract class UpdateProfileRepos {
  Future<Response> updateEmail({required email, required password});

  Future<Response>  updateProfile({required email, required password});

  Future<Response> updatePhone({required phone, required password});

  Future<Response> changePassword(
      {required oldPassword, required newPassword, required confirmPassword});
  Future<Response> registerAsATeacher(data);


}
