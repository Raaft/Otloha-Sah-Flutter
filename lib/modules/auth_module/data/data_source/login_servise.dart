// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_base/core/data/chash_helper.dart';
import 'package:flutter_base/core/network/api_base_helper.dart';
import 'package:flutter_base/core/utils/constant/constants.dart';
import 'package:flutter_base/modules/auth_module/data/repositories/login_repo.dart';

class Auth extends AuthRepository {
  @override
  Future<Response> userLogIn({
    email,
    password,
  }) async {
    return await ApiBaseHelperForAuth().postHTTP('/api/v1/login/', {
      'email': email,
      'password': password,
    });
    //throw UnimplementedError();
  }

  @override
  Future<Response> logOut({String? auth}) {
    return ApiBaseHelper().postHTTP('/api/v1/logout/', {});
  }

  @override
  Future<Response> passwordReset({email}) {
    return ApiBaseHelper().postHTTP('/api/v1/logout/', {
      'username': email,
    });
  }

  @override
  Future<Response> passwordResetConfirm(
      {uid, token, new_password1, new_password2}) {
    return ApiBaseHelper().postHTTP('/api/v1/password/reset/confirm/', {
      'uid': uid,
      'token': token,
      'new_password1': new_password1,
      'new_password2': new_password2,
    });
  }

  @override
  Future<Response> passwordChange(
      {old_password, new_password1, new_password2}) {
    try {
      return ApiBaseHelper().postHTTP('/api/v1/password/change/', {
        'old_password': old_password,
        'new_password1': new_password1,
        'new_password2': new_password2,
      });
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Future<Response> refreshToken() {
    return ApiBaseHelper().postHTTP('/api/v1/token/refresh/', {});
  }

  @override
  Future<Response> userRegister(
      {email, username, password1, password2, birthdate, phone, gender}) {
    return ApiBaseHelperForAuth().postHTTP('/api/v1/signup/', {
      'email': email,
      'password1': password1,
      'password2': password2,
      'username': username,
      'phone': phone,
      'birthdate': birthdate,
      'gender': gender,
    });
  }

  @override
  Future<Response> getProfile() async {
    Response? response = await ApiBaseHelper().getHTTP('/api/v1/profile/');
    await CacheHelper.saveData(
        key: profile, value: json.encode(response!.data));
    return response;
  }
}
