import 'package:dio/dio.dart';
//import 'package:flutter_app/models/course_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

class CourseService {
  final Dio _dio = Dio();
  final Logger _logger = Logger();

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

  Future<List<String>> fetchAllCourse() async {
    try {
      final response = await _dio.post('http://192.168.1.7:8080/course/get');

      if (response.statusCode != 200) {
        throw Exception("Courses can't be fetched");
      }
      final List<dynamic> data = response.data;
      return data.cast<String>();
    } catch (error, stackTrace) {
      _logger.e("Error occurred", error: error, stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<List<String>> fetchMyCourse({required int? userId}) async {
    try {
      final response = await _dio.post(
        'http://192.168.1.7:8080/course/user/get',
        options: Options(
        headers: {
          'user_id': userId, 
          },
        ),
      );

      if (response.statusCode != 200) {
        throw Exception("Courses can't be fetched");
      }
      final List<dynamic> data = response.data;
      return data.cast<String>();
    } catch (error, stackTrace) {
      _logger.e("Error occurred", error: error, stackTrace: stackTrace);
      rethrow;
    }
  }
 
}



