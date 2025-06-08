import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/course/course_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/bloc/course/course_bloc.dart';
import 'package:flutter_app/bloc/course/course_state.dart';

class SeeMyCoursesScreen extends StatelessWidget {
  const SeeMyCoursesScreen({super.key});

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
                    title: Text(course,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text("No courses available."));
          }
        },
      ),
    );
  }
}
