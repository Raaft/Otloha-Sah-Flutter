import 'package:dio/dio.dart';
import 'package:flutter_base/core/network/api_base_helper.dart';
import 'package:flutter_base/modules/home/data/Repo/repo_profile.dart';

class ProfileServ extends ProfileRepository{
  @override
  Future<Response?> UserProfile() async{
    return await ApiBaseHelper().getHTTP('/api/v1/users/:id/');
  }

}