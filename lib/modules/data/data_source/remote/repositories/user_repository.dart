import 'package:flutter_base/modules/data/model/teacher_response_entity.dart';

abstract class UserRepository {
  Future<TeacherResponse?>? getTeacher();
  Future<TeacherResponse?>? getStudents();
  Future<String?>? sendMessage(int id, List<int> users);
}
