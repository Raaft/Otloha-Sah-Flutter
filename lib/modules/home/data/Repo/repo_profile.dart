import 'package:flutter_base/modules/home/data/models/user/user_prfile.dart';

abstract class ProfileRepository {
  Future<UserProfile?>? myProfile();
  Future<UserProfile?>? userProfile(int id);
}
