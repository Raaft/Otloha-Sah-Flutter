import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class AuthRepository {
  Future<Response> userLogIn({
    @required email,
    @required password,
  });

  Future<Response> userRegister(
      {@required email, @required password, @required name, @required phone});
}
