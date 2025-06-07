import 'package:flutter_app/models/course_model.dart';

abstract class CourseState {}

class CourseInitial extends CourseState{}

class CourseLoading extends CourseState{} 



class CourseLoaded extends CourseState {
  final List<CourseModel> course;

  CourseLoaded(this.course);
}

class CourseAdded extends CourseState {}

class CourseError extends CourseState {
  final String message;
  CourseError(this.message);
}
