import 'package:flutter_base/core/network/api_base_helper.dart';
import 'package:flutter_base/modules/home/data/Repo/repo_profile.dart';
import 'package:flutter_base/modules/home/data/models/user/user_prfile.dart';

class ProfileServ extends ProfileRepository {
  @override
  Future<UserProfile?>? myProfile() async {
    var response = await ApiBaseHelper().getHTTP('/api/v1/profile/');
    if (response!.statusCode == 200) {
      if (response.data != null) {
        return UserProfile.fromJson(response.data);
      }
    }
    return null;
  }

  @override
  Future<UserProfile?>? userProfile(int id) async {
    var response = await ApiBaseHelper().getHTTP('/api/v1/users/$id/');
    if (response!.statusCode == 200) {
      if (response.data != null) {
        return UserProfile.fromJson(response.data);
      }
    }
    return null;
  }
}
