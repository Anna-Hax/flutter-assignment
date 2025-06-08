import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/course/course_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/bloc/course/course_bloc.dart';
import 'package:flutter_app/bloc/course/course_state.dart';

class SeeMyCoursesScreen extends StatelessWidget {
  const SeeMyCoursesScreen({super.key});

  void _showCourseDialog(BuildContext context, String courseName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: const Text(
            'Enroll in Course',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(
            'Do you want to delete course "$courseName"?',
            style: const TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text(
                'No',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                _deletecourse(context, courseName);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 219, 32, 7),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Yes',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _deletecourse(BuildContext context, String courseName) {
    context.read<CourseBloc>().add(RemoveCourse(courseName));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Successfully deleted course "$courseName"!'),
        backgroundColor: Colors.green[400],
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
    context.read<CourseBloc>().add(MyCourseRequested());
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CourseBloc>().add(MyCourseRequested());
    });
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(title: const Text('My Courses')),
      body: BlocConsumer<CourseBloc, CourseState>(
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
        },
        builder: (context, state) {
          if (state is CourseLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MyCourseLoaded) {
            final List<String> courses = state.courses;
            if (courses.isEmpty) {
              return const Center(child: Text("You haven't enrolled in any courses yet."));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final course = courses[index];
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: Icon(Icons.book, color: Colors.teal[400]),
                    title: Text(
                      course,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey[400],
                      size: 16,
                    ),
                    onTap: () {
                      _showCourseDialog(context, course);
                    },
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text("No courses enrolled."));
          }
        },
      ),
    );
  }
}