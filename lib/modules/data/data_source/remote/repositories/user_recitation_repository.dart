import 'package:flutter_base/modules/data/model/user_recitation.dart';

abstract class UserRecitationRepository {
  Future<UserRecitation>? saveUserReciataion(
      {required UserRecitation userRecitation});

  Future<List<UserRecitation>>? getUserReciataions();

  Future<List<UserRecitation>>? getGeneraBoXMessage();
  Future<UserRecitation?>? getTeacher();
}
