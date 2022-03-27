import 'package:dio/dio.dart';
import 'package:flutter_base/core/network/api_base_helper.dart';
import 'package:flutter_base/modules/teachers/data/teacher_repo/teacher_repo.dart';

class TeacherDataService {
  @override
  Future<Response> markAsFavTeacher({required int? id}) async {
    return await ApiBaseHelper().postHTTP(
        '/api/v1/users/mark-as-fav-teacher/', {'teacher': id});
  }
}