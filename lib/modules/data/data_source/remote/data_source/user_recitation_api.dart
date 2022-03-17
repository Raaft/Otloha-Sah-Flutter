import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_base/core/network/api_base_helper.dart';
import 'package:flutter_base/core/network/dio_utils.dart';
import 'package:flutter_base/core/utils/constant/constants.dart';
import 'package:flutter_base/modules/data/data_source/local/database/database/database.dart';
import 'package:flutter_base/modules/data/data_source/remote/repositories/user_recitation_repository.dart';
import 'package:flutter_base/modules/data/model/GeneralResponse.dart';
import 'package:flutter_base/modules/data/model/user_recitation.dart';

class UserRecitationApi extends UserRecitationRepository {
  @override
  Future<UserRecitation>? saveUserReciataion(
      {required UserRecitation userRecitation}) async {
    var map = userRecitation.toMap();

    File file = File(userRecitation.record ?? '');

    map['record'] = await MultipartFile.fromFile(file.path,
        filename: file.path.split('/').last);
    Response response =
        await ApiBaseHelper().postPhotoHTTP('/api/v1/recitations/create/', map);

    if (response.statusCode == 201 || response.statusCode == 200) {
      userRecitation = UserRecitation.fromJson(response.data);
      await AppDatabase().userRecitationDao.delete(userRecitation.id ?? 0);
    } else {
      print('Error Api ' + response.data.toString());
    }

    return userRecitation;
  }

  @override
  Future<List<UserRecitation>>? getUserReciataions() async {
    Response? response =
        await ApiBaseHelper().getHTTP('/api/v1/recitations/list/');

    List<UserRecitation>? userRecitatios = [];

    if (response != null &&
        (response.statusCode == 201 || response.statusCode == 200)) {
      if (response.data != null) {
        userRecitatios = (response.data as List)
            .map((element) => UserRecitation.fromJson(element))
            .toList();
      }
    } else {
      print('Error Api ' + response!.data.toString());
    }

    return userRecitatios;
  }

  @override
  Future<List<GeneralResponse>?>? getGeneraBoXMessage() async {
    Response? response =
        await ApiBaseHelper().getHTTP('$baseUrl/api/v1/recitations/general/');

    List<GeneralResponse>? generalResponses;

    if (response != null &&
        (response.statusCode == 201 || response.statusCode == 200)) {
      if (response.data != null) {
        print('data ${response.data}');
        generalResponses = (response.data as List)
            .map((data) => GeneralResponse.fromJson(data))
            .toList();
      }
    } else {
      print('Error Api ' + response!.data.toString());
    }

    return generalResponses;
  }

  Future<UserRecitation?>? getTeacher() async {
    Response? response =
        await ApiBaseHelper().getHTTP('/api/v1/recitations/general/');

    UserRecitation? userRecitatios;

    if (response != null &&
        (response.statusCode == 201 || response.statusCode == 200)) {
      if (response.data != null) {
        userRecitatios = UserRecitation.fromJson(response.data);
      }
    } else {
      print('Error Api ' + response!.data.toString());
    }

    return userRecitatios;
  }
}
