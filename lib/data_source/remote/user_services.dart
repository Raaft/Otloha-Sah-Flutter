import 'package:dio/dio.dart';
import '../models/database_model/teacher_response_entity.dart';
import '../models/home_models/user_profile.dart';

import '../../core/network/api_base_helper.dart';

class UserServices {
  Future<Response> changePassword(
      {required oldPassword,
      required newPassword,
      required confirmPassword}) async {
    return await ApiBaseHelper().putHTTP('/api/v1/password/change/', {
      'old_Password': oldPassword,
      'new_Password1': newPassword,
      'new_Password2': confirmPassword,
    });
  }

  Future<Response> updateEmail({required email, required password}) async {
    return await ApiBaseHelper().putHTTP('/api/v1/profile/email/update/', {
      'email': email,
      'password': password,
    });
  }

  Future<Response> updatePhone({required phone, required password}) async {
    return await ApiBaseHelper().putHTTP('/api/v1/profile/update/phone/',
        {'phone': phone, 'password': password});
  }

  Future<Response> updateProfile({required email, required password}) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }

  Future<Response> registerAsATeacher(data) async {
    return await ApiBaseHelper()
        .postHTTP('/api/v1/users/register-as-a-teacher/', data);
  }

  Future<Response> markAsFavTeacher({required int? id}) async {
    return await ApiBaseHelper()
        .postHTTP('/api/v1/users/mark-as-fav-teacher/', {'teacher': id});
  }

  Future<UserProfile> myProfile() async {
    var response = await ApiBaseHelper().getHTTP('/api/v1/profile/');
    print('User is =>> ${UserProfile.fromJson(response!.data).firstName}');
    return UserProfile.fromJson(response.data);
  }

  Future<UserProfile> userProfile(int id) async {
    var response = await ApiBaseHelper().getHTTP('/api/v1/users/$id/');
    return UserProfile.fromJson(response!.data);
  }

  Future<List<TeacherResponse>?>? getTeacher(int page) async {
    Response? response = await ApiBaseHelper()
        .getHTTP('/api/v1/users/teachers/', queryParameters: {'page': page});

    List<TeacherResponse>? teachers;

    teachers = (response!.data['results'] as List)
        .map((e) => TeacherResponse.fromJson(e))
        .toList();

    return teachers;
  }

  Future<List<TeacherResponse>?> getStudents(int page) async {
    Response? response = await ApiBaseHelper()
        .getHTTP('/api/v1/users/students/', queryParameters: {'page': page});

    List<TeacherResponse>? teachers;

    teachers = (response!.data['results'] as List)
        .map((e) => TeacherResponse.fromJson(e))
        .toList();

    return teachers;
  }

  Future<String?>? sendMessage(int id, List<int> users) async {
    var response = await ApiBaseHelper().postHTTP(
      '/api/v1/recitations/$id/messages/send/',
      {'users': users},
    );
    return response.data['message'];
  }
}
