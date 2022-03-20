import 'package:flutter_base/modules/data/model/teacher_response_entity.dart';

abstract class UserRepository {
  Future<TeacherResponse?>? getTeacher();
  Future<TeacherResponse?>? getStudents();
  Future? sendMessage(int id, int msgId, List<int> users);
}
