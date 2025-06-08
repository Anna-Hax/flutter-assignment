abstract class CourseState {}

class CourseInitial extends CourseState{}

class CourseLoading extends CourseState{} 

class AllCourseLoaded extends CourseState {
  final List<String> courses;

  AllCourseLoaded(this.courses);
}

class MyCourseLoaded extends CourseState {
  final List<String> courses;

  MyCourseLoaded(this.courses);
}

class AddingCourse extends CourseState {}

class CourseAdded extends CourseState {}

class CourseError extends CourseState {
  final String message;
  CourseError(this.message);
}

class RemovingCourse extends CourseState{}
class RemovedCourse extends CourseState{}