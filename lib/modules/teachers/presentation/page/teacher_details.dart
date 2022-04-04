import 'package:flutter/material.dart';

import '../../../../data_source/models/database_model/teacher_response_entity.dart';
import '../widgets/teacher_detalis_Widget.dart';
class TeacherDetails extends StatelessWidget {
  const TeacherDetails({Key? key, required this.results}) : super(key: key);
final TeacherResponse results;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: teacherDetailsBody(results),);
  }
}
