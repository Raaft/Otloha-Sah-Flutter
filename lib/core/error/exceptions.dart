import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/error/failure.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NetworkConnectionException implements Exception {}

class InvalidData implements Exception {
  final Map<String, dynamic>? _errors;
  String? msg;

  InvalidData(this._errors, this.msg);

  Map<String, dynamic>? get errors => _errors;
}

class ServerError implements Exception {}

class CacheError implements Exception {}

class SomeThingWentWrong implements Exception {}

class ExceptionHandling {
  static handleDioExceprion(DioError e) {
    if (e.type == DioErrorType.other) {
      print(e.type);
      throw NetworkConnectionException();
    } else if (e.type == DioErrorType.response) {
      if (e.response!.statusCode! == 400 || e.response!.statusCode! == 422) {
        print(e.response!.data);
        throw InvalidData(e.response!.data, e.response!.data['msg']);
      }
      if (e.response!.statusCode! >= 500) {
        print(e.response!.data);
        throw ServerError();
      }
    } else if (e.type == DioErrorType.connectTimeout) {
      throw TimeoutException('time out');
    }

    throw SomeThingWentWrong();
  }

  static handleExceptionToFaliure(Exception e) {
    if (e is NetworkConnectionException) {
      return NetworkFailure();
    } else if (e is InvalidData) {
      return InvalidDataFailure(e.errors!);
    } else if (e is ServerError) {
      return ServerFailure();
    } else if (e is TimeoutException) {
      return NetworkFailure();
    }

    return SomeThingWentWrongFailure();
  }

  static hanleToastException(
      Function function, String doneMessage, bool isShow) async {
    try {
      await function();
      if (isShow) {
        Fluttertoast.showToast(
            msg: doneMessage,
            backgroundColor: Colors.green,
            timeInSecForIosWeb: 4);
      }
    } on InvalidData catch (e) {
      print(e);
      Fluttertoast.showToast(msg: e.msg!);
    } on NetworkConnectionException catch (_) {
      Fluttertoast.showToast(
          msg: 'Network error check your internet exception');
    } on TimeoutException catch (_) {
      Fluttertoast.showToast(msg: 'Time out');
    } on ServerError catch (_) {
      Fluttertoast.showToast(msg: 'Server Error');
    } on SomeThingWentWrong catch (_) {
      Fluttertoast.showToast(msg: 'Something went wrong');
    }
  }
}
