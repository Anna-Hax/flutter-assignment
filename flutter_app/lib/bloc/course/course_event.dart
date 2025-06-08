abstract class CourseEvent {}

class AllCourseRequested extends CourseEvent{}

class MyCourseRequested extends CourseEvent{}

class AddCourse extends CourseEvent{
  final String course;
  AddCourse(this.course);
}

class RemoveCourse extends CourseEvent{}

