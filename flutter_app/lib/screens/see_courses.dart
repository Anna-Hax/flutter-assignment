import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/auth/auth_bloc.dart';
import 'package:flutter_app/bloc/auth/auth_state.dart';
import 'package:flutter_app/bloc/course/course_bloc.dart';
import 'package:flutter_app/bloc/course/course_state.dart';
import 'package:flutter_app/screens/login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeeCoursesScreen extends StatelessWidget {
  const SeeCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthUnauthenticated) {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => LoginScreen()));
              }
              if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red[400],
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
          ),
          BlocListener<CourseBloc, CourseState>(
            listener: (context, state) {
              if (state is CourseError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red[400],
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
              // CircularProgressIndicator should not be here
            },
          ),
        ],
        child: BlocBuilder<CourseBloc, CourseState>(
          builder: (context, state) {
            if (state is CourseLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is AllCourseLoaded) {
              final courses = state.course; // assuming state has a 'courses' list
              return ListView.builder(
                padding: EdgeInsets.all(20),
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  final course = courses[index];
                  return Card(
                    child: ListTile(
                      title: Text(course as String)
                    ),
                  );
                },
              );
            } else {
              return Center(child: Text("No courses available."));
            }
          },
        ),
      ),
    );
  }
}
