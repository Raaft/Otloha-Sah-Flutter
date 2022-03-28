import 'package:flutter_base/core/network/api_base_helper.dart';

import '../models/home_models/user_prfile.dart';

class ProfileServices {
  Future<UserProfile> myProfile() async {
    var response = await ApiBaseHelper().getHTTP('/api/v1/profile/');
    return UserProfile.fromJson(response!.data);
  }

  Future<UserProfile> userProfile(int id) async {
    var response = await ApiBaseHelper().getHTTP('/api/v1/users/$id/');
    return UserProfile.fromJson(response!.data);
  }
}
