import 'package:flutter_base/modules/data/model/general_response.dart';
import 'package:flutter_base/modules/data/model/recitations.dart';
import 'package:flutter_base/modules/data/model/user_recitation.dart';

abstract class UserRecitationRepository {
  Future<UserRecitation>? saveUserReciataion(
      {required UserRecitation userRecitation});

  Future<Recitations?>? getUserReciataions();

  Future<List<GeneralResponse>?>? getGeneraBoXMessage();
}
