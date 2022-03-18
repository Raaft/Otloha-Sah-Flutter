// ignore_for_file: non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:flutter_base/core/network/api_base_helper.dart';
import 'package:flutter_base/modules/auth_module/data/repositories/login_repo.dart';

class Auth extends AuthRepository {
  @override
  Future<Response?>? userLogIn({
    email,
    password,
  }) {

      return ApiBaseHelperForAuth().postHTTP(
          '/api/v1/login/',
          {
            'email': email,
            'password': password,
          },
          isAuth: true);

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
      return ApiBaseHelper().postHTTP('/api/v1/token/refresh/', {});
    } catch (e) {
      throw UnimplementedError();
    }
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
}
