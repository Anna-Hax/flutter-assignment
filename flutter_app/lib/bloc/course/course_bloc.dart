import 'package:flutter_app/bloc/course/course_event.dart';
import 'package:flutter_app/bloc/course/course_state.dart';
import 'package:flutter_app/data/course_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState>{
  final CourseService courseService;
  
  CourseBloc(this.courseService) : super(CourseInitial()){
    on<AddCourse>((event, emit) async {
      emit(AddingCourse());
      final prefs = await SharedPreferences.getInstance();
      final int? userId = prefs.getInt('id');
      try{
        // ignore: unused_local_variable
        final courseModel = await courseService.addMyCourse(course: event.course, userId: userId);
        emit(CourseAdded());
      } catch (error) {
        emit(CourseError("Adding Course Error!"));
      }
    });
    on<RemoveCourse>((event, emit) async {
      emit(RemovingCourse());
      try {
        // ignore: unused_local_variable
        final courseNames = await courseService.removeMyCourse(course: event.course);
        emit(RemovedCourse());
      } catch (error) {
        emit(CourseError("Problem in Fetching your courses"));
      }
    });
    on<MyCourseRequested>((event, emit) async {
      emit(CourseLoading());
      final prefs = await SharedPreferences.getInstance();
      final int? userId = prefs.getInt('id');

      try {
        final courseNames = await courseService.fetchMyCourse(userId: userId);
        emit(MyCourseLoaded(courseNames));
      } catch (error) {
        emit(CourseError("Problem in Fetching your courses"));
      }
    });
    on<AllCourseRequested>((event, emit) async {
      emit(CourseLoading());
      try {
        final courseNames = await courseService.fetchAllCourse();
        emit(AllCourseLoaded(courseNames));
      } catch (error) {
        emit(CourseError("Problem in Fetching your courses"));
      }
    });
    
  }
}