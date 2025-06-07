import 'package:flutter_app/models/course_model.dart';

abstract class CourseEvent {}

//all
class AllCourseRequested extends CourseEvent{
  final List<AllCourseModel> course;

  AllCourseRequested(this.course);
}

//user's
class MyCourseRequested extends CourseEvent{
  final List<AllCourseModel> course;
  MyCourseRequested(this.course);
}

class AddCourse extends CourseEvent{
  final String course;
  AddCourse(this.course);
}

class RemoveCourse extends CourseEvent{}

