import 'package:flutter_base/data_source/models/database_model/general_response.dart';
import 'package:flutter_base/data_source/models/database_model/recitations.dart';
import 'package:flutter_base/data_source/models/database_model/user_recitation.dart';

abstract class UserRecitationRepository {
  Future<UserRecitation>? saveUserReciataion(
      {required UserRecitation userRecitation});

  Future<Recitations?>? getUserReciataions();

  Future<List<GeneralResponse>?>? getGeneraBoXMessage();
}
