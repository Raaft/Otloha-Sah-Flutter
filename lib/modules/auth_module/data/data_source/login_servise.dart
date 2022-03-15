// ignore_for_file: non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:flutter_base/core/network/api_base_helper.dart';
import 'package:flutter_base/modules/auth_module/data/repositories/login_repo.dart';

class Auth extends AuthRepository {
  @override
  Future<Response> userRegister({email, password, name, phone}) {
    ApiBaseHelper().postHTTP('', {
      'email': email,
      'password': password,
      'name': name,
      'phone': phone,
    });
    throw UnimplementedError();
  }

  @override
  Future<Response> userLogIn({
    email,
    password,
  }) {
    try {
      return ApiBaseHelper().postHTTP('/api/v1/login/', {
        // 'grant_type': 'password',
        // 'client_id': '8ptVgPCrQaMoWVyntEhnmYCj71kH8hVmkNVz4Win',
        // 'client_secret':'rmobDabTG9GMuFm3mPAA1Lt9CxV9KT7EVrbFMd2zMkbtv9ZCniAbnO8nUiRaRf8GYRn1Zwxky0zrBp37pMXwI4XtVHnTu02PD16KAf4jzqCiKe0RYQITXyDVPAmck1L9',
        'username': email,
        'password': password,
      });
    } catch (e) {
      throw UnimplementedError();
    }
    //throw UnimplementedError();
  }

  @override
  Future<Response> logOut({String? auth}) {
    try {
      return ApiBaseHelper().postHTTP('/api/v1/logout/', {});
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Future<Response> passwordReset({email}) {
    try {
      return ApiBaseHelper().postHTTP('/api/v1/logout/', {
        'username': email,
      });
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Future<Response> passwordResetConfirm(
      {uid, token, new_password1, new_password2}) {
    try {
      return ApiBaseHelper().postHTTP('/api/v1/password/reset/confirm/', {
        'uid': uid,
        'token': token,
        'new_password1': new_password1,
        'new_password2': new_password2,
      });
    } catch (e) {
      throw UnimplementedError();
    }
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
    try {
      return ApiBaseHelper().postHTTP(' /api/v1/token/refresh/', {});
    } catch (e) {
      throw UnimplementedError();
    }
  }
}
