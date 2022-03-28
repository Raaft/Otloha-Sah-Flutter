import 'package:dio/dio.dart';
import 'package:flutter_base/data_source/models/database_model/teacher_response_entity.dart';
import 'package:flutter_base/data_source/models/home_models/user_prfile.dart';

import '../../core/network/api_base_helper.dart';

class UserServices  {
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
    return await ApiBaseHelper().putHTTP('/api/v1/profile/update/phone/', {
      'phone': phone,
      'password': password});
  }

  Future<Response> updateProfile({required email, required password}) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }

  Future<Response> registerAsATeacher(data) async{
    return await ApiBaseHelper().postHTTP('/api/v1/users/register-as-a-teacher/', data);

  }

  Future<Response> markAsFavTeacher({required int? id}) async {
    return await ApiBaseHelper()
        .postHTTP('/api/v1/users/mark-as-fav-teacher/', {'teacher': id});
  }

  Future<UserProfile> myProfile() async {
    var response = await ApiBaseHelper().getHTTP('/api/v1/profile/');
    return UserProfile.fromJson(response!.data);
  }

  Future<UserProfile> userProfile(int id) async {
    var response = await ApiBaseHelper().getHTTP('/api/v1/users/$id/');
    return UserProfile.fromJson(response!.data);
  }


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
