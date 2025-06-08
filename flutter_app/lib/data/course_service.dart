import 'package:dio/dio.dart';
//import 'package:flutter_app/models/course_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

class CourseService {
  final Dio _dio = Dio();
  final Logger _logger = Logger();

  //get Courses
  
  Future<void> addMyCourse({required String course, required int? userId}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final storedUserId = prefs.getInt('id') ?? userId;

      if (storedUserId == null) {
        _logger.e("User ID is null — cannot add course.");
        throw Exception("User ID is missing.");
      }

      _logger.i("Attempting to add course: $course for user ID: $storedUserId");

      final response = await _dio.post(
        'http://192.168.1.7:8080/course/user/create',
        data: {
          "user_id": storedUserId,
          "course": course,
        },
      );

      _logger.i("Response Status: ${response.statusCode}");
      _logger.i("Response Data: ${response.data}");

      if (response.statusCode != 200) {
        _logger.e("Failed to add course. Status code: ${response.statusCode}, Body: ${response.data}");
        throw Exception("Course not added. Try again.");
      }

      _logger.i("Course '$course' added successfully for user $storedUserId.");
    } catch (error, stackTrace) {
      _logger.e("Exception while adding course", error: error, stackTrace: stackTrace);
      rethrow;
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



