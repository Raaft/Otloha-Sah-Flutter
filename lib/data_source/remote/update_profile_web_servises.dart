import 'package:dio/dio.dart';

import '../../core/network/api_base_helper.dart';

class UpdateProfile  {
  Future<Response> changePassword(
      {required oldPassword,
        required newPassword,
        required confirmPassword}) async {
    return await ApiBaseHelper().putHTTP('/api/v1/password/change/', {
      'old_Password': oldPassword,
      'new_Password1': newPassword,
      'new_Password2': confirmPassword,
    });
  }

  Future<Response> updateEmail({required email, required password}) async {
    return await ApiBaseHelper().putHTTP('/api/v1/profile/email/update/', {
      'email': email,
      'password': password,
    });
  }

  Future<Response> updatePhone({required phone, required password}) async {
    return await ApiBaseHelper().putHTTP('/api/v1/profile/update/phone/', {
      'phone': phone,
      'password': password});
  }

  Future<Response> updateProfile({required email, required password}) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }

  Future<Response> registerAsATeacher(data) async{
    return await ApiBaseHelper().postHTTP('/api/v1/users/register-as-a-teacher/', data);

  }

}
