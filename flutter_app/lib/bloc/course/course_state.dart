import 'package:flutter_app/models/course_model.dart';

abstract class CourseState {}

class CourseInitial extends CourseState{}

class CourseLoading extends CourseState{} 

class AllCourseLoaded extends CourseState {
  final List<AllCourseModel> course;

  AllCourseLoaded(this.course);
}

class MyCourseLoaded extends CourseState {
  final List<AllCourseModel> course;

  MyCourseLoaded(this.course);
}

class AddingCourse extends CourseState {}

class CourseAdded extends CourseState {}

class CourseError extends CourseState {
  final String message;
  CourseError(this.message);
}
