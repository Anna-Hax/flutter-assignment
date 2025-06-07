import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CourseService {
  final Dio _dio = Dio();

  //get Courses
  
  Future<void> addCourse({required String course}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
  
    final response = await _dio.post('http://192.168.1.7:8080/course/add',
      data: {
        "token": token,
        "course": course
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Login failed");
    }
  }
}