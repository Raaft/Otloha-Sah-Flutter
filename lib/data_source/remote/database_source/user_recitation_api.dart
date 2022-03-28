import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_base/core/network/api_base_helper.dart';
import 'package:flutter_base/core/utils/constant/constants.dart';
import 'package:flutter_base/modules/data/data_source/remote/repositories/user_recitation_repository.dart';
import 'package:flutter_base/modules/data/model/GeneralResponse.dart';
import 'package:flutter_base/modules/data/model/recitations.dart';
import 'package:flutter_base/modules/data/model/user_recitation.dart';

class UserRecitationApi extends UserRecitationRepository {
  @override
  Future<UserRecitation>? saveUserReciataion(
      {required UserRecitation userRecitation}) async {
    var map = userRecitation.toMap();

    File file = File(userRecitation.record!);
    File wave = File(userRecitation.wavePath!);

    map['record'] = await MultipartFile.fromFile(file.path,
        filename: file.path.split('/').last);

    // map['wave'] = await MultipartFile.fromFile(wave.path,
    //     filename: wave.path.split('/').last);

    Response response =
        await ApiBaseHelper().postPhotoHTTP('/api/v1/recitations/create/', map);

    if (response.statusCode == 201 || response.statusCode == 200) {
      userRecitation = UserRecitation.fromMap(response.data);
      // await AppDatabase().userRecitationDao.insert(userRecitation);
    } else {
      print('Error Api ' + response.data.toString());
    }

    return userRecitation;
  }

  @override
  Future<Recitations?>? getUserReciataions() async {
    Response? response = await ApiBaseHelper().getHTTP('/api/v1/recitations/');

    Recitations? userRecitatios;

    print(response!.data);
    if ((response.statusCode! >= 200 && response.statusCode! < 300)) {
      userRecitatios = Recitations.fromJson(response.data);
    } else {
      print('Error Api ' + response.data.toString());
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
        userRecitatios = UserRecitation.fromMap(response.data);
      }
    } else {
      print('Error Api ' + response!.data.toString());
    }

    return userRecitatios;
  }
}
