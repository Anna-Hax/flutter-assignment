import 'package:flutter_app/models/course_model.dart';

abstract class CourseEvent {}

class CourseRequested extends CourseEvent{
  final List<CourseModel> course;

  CourseRequested(this.course);
}
class AddCourse extends CourseEvent{
  final String course;
  AddCourse(this.course);
}
class RemoveCourse extends CourseEvent{}

