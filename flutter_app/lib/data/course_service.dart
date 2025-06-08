import 'package:dio/dio.dart';
import 'package:flutter_app/models/course_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CourseService {
  final Dio _dio = Dio();

  //get Courses
  
  Future<void> addMyCourse({required String course}) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('id');
  
    final response = await _dio.post('http://127.0.0.1:8080/course/user/create',
      data: {
        "user_id": userId,
        "course": course
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Course not added");
    }
  }

  Future<AllCourseModel> fetchAllCourse({required String course}) async {
  
    final response = await _dio.post('http://192.168.1.7:8080/course/get');

    if (response.statusCode != 200) {
      throw Exception("Courses can't be fetched");
    } else {
      final model = AllCourseModel.fromJson(response.data);
      return model;
    }
  }

  Future<AllCourseModel> fetchMyCourse({required String course}) async {
  
    final response = await _dio.post('http://192.168.1.7:8080/course/user/get');

    if (response.statusCode != 200) {
      throw Exception("Courses can't be fetched");
    } else {
      final model = AllCourseModel.fromJson(response.data);
      return model;
    }
  }
}



