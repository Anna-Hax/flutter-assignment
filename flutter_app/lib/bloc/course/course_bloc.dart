import 'package:flutter_app/bloc/course/course_event.dart';
import 'package:flutter_app/bloc/course/course_state.dart';
import 'package:flutter_app/data/course_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState>{
  final CourseService courseService;

  CourseBloc(this.courseService) : super(CourseInitial()){
    on<AddCourse>((event, emit) async {
      emit(AddingCourse());
      try{
        // ignore: unused_local_variable
        final courseModel = await courseService.addCourse(course: event.course);
        emit(CourseAdded());
      } catch (error) {
        emit(CourseError("Adding Course Error!"));
      }
    });
  }
}