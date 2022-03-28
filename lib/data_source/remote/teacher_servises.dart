import 'package:dio/dio.dart';
import 'package:flutter_base/core/network/api_base_helper.dart';

class TeacherDataService {
  Future<Response> markAsFavTeacher({required int? id}) async {
    return await ApiBaseHelper()
        .postHTTP('/api/v1/users/mark-as-fav-teacher/', {'teacher': id});
  }
}
