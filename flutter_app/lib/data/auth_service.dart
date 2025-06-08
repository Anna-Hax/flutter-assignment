import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/auth_model.dart';
import 'package:logger/logger.dart';
class AuthService {

  final Dio _dio = Dio();
  final Logger _logger = Logger();
  //login
  Future<AuthModel> login({required String email, required String password}) async {
    final response = await _dio.post('http://192.168.1.7:8080/auth/login',
      data: {
        "email": email,
        "password": password,
      },
    );

    if (response.statusCode == 200){
      final model = AuthModel.fromJson(response.data);
      final pref = await SharedPreferences.getInstance();
      await pref.setInt('id', model.id);
      return model;
    } else {
      throw Exception("Login failed");
    }
  }


  //signup


  Future<AuthModel> signup({required String email, required String password}) async {
    try {
      _logger.i("Starting signup request for email: $email");
      
      final response = await _dio.post('http://192.168.1.7:8080/auth/signup',
        data: {
          "email": email,
          "password": password,
        },
      );
      
      _logger.i("Received response with status: ${response.statusCode}");

      if (response.statusCode == 200) {
        _logger.d("Parsing response data: ${response.data}");
        final model = AuthModel.fromJson(response.data);
        
        _logger.i("Getting SharedPreferences instance");
        final pref = await SharedPreferences.getInstance();
        
        _logger.i("Storing user ID: ${model.id}");
        await pref.setInt('id', model.id);
        
        _logger.i("Signup completed successfully");
        return model;
      } else {
        _logger.w("Signup failed with status: ${response.statusCode}");
        throw Exception("Signup failed");
      }
    } catch (e, stackTrace) {
      _logger.e("Signup error occurred", error: e, stackTrace: stackTrace);
      rethrow;
    }
  }



  //logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }


  //check if logged in
  Future<bool> isLoggedIn() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') != null;
  }

  //get token
  Future<String?> getToken() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}