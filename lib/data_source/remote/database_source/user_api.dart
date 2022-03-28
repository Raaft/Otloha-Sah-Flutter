import 'package:dio/dio.dart';
import 'package:flutter_base/core/network/api_base_helper.dart';
import 'package:flutter_base/data_source/models/database_model/teacher_response_entity.dart';


class UserApi {

  Future<TeacherResponse?>? getTeacher() async {
    Response? response =
        await ApiBaseHelper().getHTTP('/api/v1/users/teachers/');

    TeacherResponse? teachers;

    if (response != null &&
        (response.statusCode == 201 || response.statusCode == 200)) {
      if (response.data != null) {
        print(response.data);
        teachers = TeacherResponse.fromJson(response.data);
        return teachers;
      }
    } else {
      print('Error Api ' + response!.data.toString());
    }

    return teachers;
  }


  Future<TeacherResponse?>? getStudents() async {
    Response? response =
        await ApiBaseHelper().getHTTP('/api/v1/users/students/');

    TeacherResponse? teachers;

    if (response != null &&
        (response.statusCode == 201 || response.statusCode == 200)) {
      if (response.data != null) {
        print(response.data);
        teachers = TeacherResponse.fromJson(response.data);
      }
    } else {
      print('Error Api ' + response!.data.toString());
    }

    return teachers;
  }


  Future<String?>? sendMessage(int id, List<int> users) async {
    var response = await ApiBaseHelper().postHTTP(
      '/api/v1/recitations/$id/messages/send/',
      {'users': users},
    );
    if ((response.statusCode == 201 || response.statusCode == 200)) {
      if (response.data != null && response.data['message'] != null) {
        print(' Future<String?>? sendMessage ' + response.data['message']);
        return response.data['message'];
      }
    } else {
      print('Error Api ' + response.data.toString());
    }
    return null;
  }
}
