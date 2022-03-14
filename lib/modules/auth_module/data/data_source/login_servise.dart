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
    ApiBaseHelper().postHTTP('/o/token/', {
      'grant_type': 'password',
      'client_id': '8ptVgPCrQaMoWVyntEhnmYCj71kH8hVmkNVz4Win',
      'client_secret':
          'rmobDabTG9GMuFm3mPAA1Lt9CxV9KT7EVrbFMd2zMkbtv9ZCniAbnO8nUiRaRf8GYRn1Zwxky0zrBp37pMXwI4XtVHnTu02PD16KAf4jzqCiKe0RYQITXyDVPAmck1L9',
      'username': email,
      'password': password,
    });
    throw UnimplementedError();
  }
}
