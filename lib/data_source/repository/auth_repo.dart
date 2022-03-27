// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_base/data_source/remote/login_services.dart';

import '../../core/data/chash_helper.dart';
import '../../core/utils/constant/constants.dart';

class AuthRepository {

  final AuthApi authApi = AuthApi();

  Future<Response>? userLogIn({
    email,
    password,
  }) {
    return authApi.userLogIn(email: email, password: password);
  }

  Future<Response> logOut({String? auth}) {
    return authApi.logOut(auth: auth);
  }

  Future<Response> passwordReset({email}) {
    return authApi.passwordReset(email: email);
  }

  Future<Response> passwordResetConfirm(
      {uid, token, new_password1, new_password2}) {
    return authApi.passwordResetConfirm(uid: uid,
        new_password1: new_password1,
        new_password2: new_password2,
        token: token);
  }

  Future<Response> passwordChange(
      {old_password, new_password1, new_password2}) {
    return authApi.passwordChange(old_password: old_password,
        new_password2: new_password2,
        new_password1: new_password1);
  }

  Future<Response> refreshToken() {
    return authApi.refreshToken();
  }

  Future<Response> userRegister(
      {email, username, password1, password2, birthdate, phone, gender}) async {
    return authApi.userRegister(email: email,
        birthdate: birthdate,
        gender: gender,
        password1: password1,
        password2: password2,
        phone: phone,
        username: username);
  }

  Future<Response> getProfile() async {
    Response response = await authApi.getProfile();
    await CacheHelper.saveData(
        key: profile, value: json.encode(response.data));
    return response;
  }


}
