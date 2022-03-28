import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_base/core/network/api_base_helper.dart';
import 'package:flutter_base/core/utils/constant/constants.dart';
import 'package:flutter_base/data_source/models/database_model/GeneralResponse.dart';
import 'package:flutter_base/data_source/models/database_model/recitaion_details.dart';
import 'package:flutter_base/data_source/models/database_model/recitations.dart';
import 'package:flutter_base/data_source/models/database_model/user_recitation.dart';

class UserRecitationApi {
  Future<UserRecitation>? saveUserReciataion(
      {required UserRecitation userRecitation}) async {
    var map = userRecitation.toMap();

    File file = File(userRecitation.record!);
    // File wave = File(userRecitation.wavePath!);

    map['record'] = await MultipartFile.fromFile(file.path,
        filename: file.path.split('/').last);

    // map['wave'] = await MultipartFile.fromFile(wave.path,
    //     filename: wave.path.split('/').last);

    Response response =
        await ApiBaseHelper().postPhotoHTTP('/api/v1/recitations/create/', map);

    userRecitation = UserRecitation.fromMap(response.data);
    // await AppDatabase().userRecitationDao.insert(userRecitation);

    return userRecitation;
  }

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

  Future<List<GeneralResponse>?>? getGeneraBoXMessage() async {
    Response? response =
        await ApiBaseHelper().getHTTP('$baseUrl/api/v1/recitations/general/');

    List<GeneralResponse>? generalResponses;
    generalResponses = (response!.data as List)
        .map((data) => GeneralResponse.fromJson(data))
        .toList();

    return generalResponses;
  }

  Future<UserRecitation?>? getTeacher() async {
    Response? response =
        await ApiBaseHelper().getHTTP('/api/v1/recitations/general/');

    UserRecitation? userRecitatios;
    userRecitatios = UserRecitation.fromMap(response!.data);

    return userRecitatios;
  }

  Future<RecitationDetails?> recitationDetails(int recitationId) async {
    var value =
        await ApiBaseHelper().getHTTP('/api/v1/recitations/$recitationId');
    RecitationDetails msg = RecitationDetails.fromJson(value!.data);
    return msg;
  }
}
