import 'package:dio/dio.dart';

abstract class teacherRepo{

 Future<Response>? markAsFavTeacher({ required int id});
}