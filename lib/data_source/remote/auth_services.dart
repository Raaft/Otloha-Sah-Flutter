// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_base/data_source/cache_helper.dart';
import 'package:flutter_base/core/network/api_base_helper.dart';
import 'package:flutter_base/core/utils/constant/constants.dart';

class AuthApi {
  Future<Response> userLogIn({
    email,
    password,
  }) async {
    return await ApiBaseHelperForAuth().postHTTP('/api/v1/login/', {
      'email': email,
      'password': password,
    });
  }

  Future<Response> logOut({String? auth}) async {
    return await ApiBaseHelper().postHTTP('/api/v1/logout/', {});
  }

  Future<Response> passwordReset({email}) {
    return ApiBaseHelper().postHTTP('/api/v1/logout/', {
      'username': email,
    });
  }

  Future<Response> passwordResetConfirm(
      {uid, token, new_password1, new_password2}) {
    return ApiBaseHelper().postHTTP('/api/v1/password/reset/confirm/', {
      'uid': uid,
      'token': token,
      'new_password1': new_password1,
      'new_password2': new_password2,
    });
  }

  Future<Response> passwordChange(
      {old_password, new_password1, new_password2}) async {
    return await ApiBaseHelper().postHTTP('/api/v1/password/change/', {
      'old_password': old_password,
      'new_password1': new_password1,
      'new_password2': new_password2,
    });
  }

  Future<Response> refreshToken() async {
    return await ApiBaseHelper().postHTTP('/api/v1/token/refresh/', {});
  }

  Future<Response> userRegister(
      {email, username, password1, password2, birthdate, phone, gender}) async {
    return await ApiBaseHelperForAuth().postHTTP('/api/v1/signup/', {
      'email': email,
      'password1': password1,
      'password2': password2,
      'username': username,
      'phone': phone,
      'birthdate': birthdate,
      'gender': gender,
    });
  }

  Future<Response> getProfile() async {
    var response = await ApiBaseHelper().getHTTP('/api/v1/profile/');
    await CacheHelper.saveData(
        key: profile, value: json.encode(response!.data));
    await CacheHelper.saveData(
        key: userProfileLogined, value: json.encode(response.data));
    return response;
  }
}
