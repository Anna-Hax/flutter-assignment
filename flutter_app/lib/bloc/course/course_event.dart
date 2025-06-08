abstract class CourseEvent {}

//all
class AllCourseRequested extends CourseEvent{}

//user's
class MyCourseRequested extends CourseEvent{}

class AddCourse extends CourseEvent{
  final String course;
  AddCourse(this.course);
}

class RemoveCourse extends CourseEvent{}

