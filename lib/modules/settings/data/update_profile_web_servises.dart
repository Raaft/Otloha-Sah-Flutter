import 'package:dio/dio.dart';
import 'package:flutter_base/modules/settings/data/repo/settingRepo.dart';

import '../../../core/network/api_base_helper.dart';

class UpdateProfile extends UpdateProfileRepos {
  @override
  Future<Response> changePassword(
      {required oldPassword,
      required newPassword,
      required confirmPassword}) async {
    try {
      return await ApiBaseHelper().putHTTP('/api/v1/password/change/', {
        'old_Password': oldPassword,
        'new_Password1': newPassword,
        'new_Password2': confirmPassword,
      });
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Future<Response> updateEmail({required email, required password}) async {
    try {
      return await ApiBaseHelper().putHTTP('/api/v1/profile/update/email/', {
        'email': email,
        'password': password,
      });
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Future<Response> updatePhone({required phone, required password}) async {
    try {
      return await ApiBaseHelper().putHTTP('//api/v1/profile/update/phone/', {
        'phone': phone,
        'password': password,
      });
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Future<Response> updateProfile({required email, required password}) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }
}
