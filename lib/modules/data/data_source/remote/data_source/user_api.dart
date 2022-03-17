import 'package:dio/dio.dart';
import 'package:flutter_base/core/network/api_base_helper.dart';
import 'package:flutter_base/modules/data/data_source/remote/repositories/user_repository.dart';
import 'package:flutter_base/modules/data/model/teacher_response_entity.dart';

class UserApi extends UserRepository {
  @override
  Future<TeacherResponse?>? getTeacher() async {
    Response? response =
        await ApiBaseHelper().getHTTP('/api/v1/users/teachers/');

    TeacherResponse? teachers;

    if (response != null &&
        (response.statusCode == 201 || response.statusCode == 200)) {
      if (response.data != null) {
        teachers = TeacherResponse.fromJson(response.data);
      }
    } else {
      print('Error Api ' + response!.data.toString());
    }

    return teachers;
  }

  @override
  Future<TeacherResponse?>? getStudents() async {
    Response? response =
        await ApiBaseHelper().getHTTP('/api/v1/users/students/');

    TeacherResponse? teachers;

    if (response != null &&
        (response.statusCode == 201 || response.statusCode == 200)) {
      if (response.data != null) {
        teachers = TeacherResponse.fromJson(response.data);
      }
    } else {
      print('Error Api ' + response!.data.toString());
    }

    return teachers;
  }
}
