import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/auth/auth_bloc.dart';
import 'package:flutter_app/bloc/auth/auth_state.dart';
import 'package:flutter_app/bloc/course/course_bloc.dart';
import 'package:flutter_app/data/auth_service.dart';
import 'package:flutter_app/data/course_service.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:flutter_app/screens/signup.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final authService = AuthService();
  final courseService = CourseService();
  runApp(MyApp(authService, courseService));
}

class MyApp extends StatelessWidget{
  final AuthService authService;
  final CourseService courseService;
  const MyApp(this.authService, this.courseService, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => AuthBloc(authService)
        ),
        BlocProvider<CourseBloc>(
          create: (BuildContext context) => CourseBloc(courseService)
        )],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state){
            if (state is AuthAuthenticated) return HomeScreen();
            if (state is AuthUnauthenticated || state is AuthInitial) return SignupScreen();
            return Center(child: CircularProgressIndicator());
          }
        )
      )
    );
  }
}
