import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/auth_model.dart';

class AuthService {

  final Dio _dio = Dio();

  //login
  Future<AuthModel> login({required String email, required String password}) async {
    final response = await _dio.post('http://localhost:8080/auth/login',
      data: {
        "email": email,
        "password": password,
      },
    );

    if (response.statusCode == 200){
      final model = AuthModel.fromJson(response.data);
      final pref = await SharedPreferences.getInstance();
      await pref.setString('token', model.token);
      return model;
    } else {
      throw Exception("Login failed");
    }
  }


  //signup
  Future<AuthModel> signup({required String email, required String password}) async {
    final response = await _dio.post('http://localhost:8080/auth/signup',
      data: {
        "email": email,
        "password": password,
      },
    );

    if (response.statusCode == 200){
      final model = AuthModel.fromJson(response.data);
      final pref = await SharedPreferences.getInstance();
      await pref.setString('token', model.token);
      return model;
    } else {
      throw Exception("Signup failed");
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