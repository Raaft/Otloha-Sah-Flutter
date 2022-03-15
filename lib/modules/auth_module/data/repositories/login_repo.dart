// ignore_for_file: non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class AuthRepository {
  Future<Response> userLogIn({
    @required email,
    @required password,
  });

  Future<Response> userRegister(
      {@required email, @required password, @required name, @required phone});

  Future<Response> logOut({String auth});

  Future<Response> passwordReset({@required email});

  Future<Response> passwordResetConfirm({
    @required uid,
    @required token,
    @required new_password1,
    @required new_password2,
  });

  Future<Response> passwordChange({
    @required old_password,
    @required new_password1,
    @required new_password2,
  });

  Future<Response> refreshToken();
}
