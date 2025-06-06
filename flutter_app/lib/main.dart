import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/auth_bloc.dart';
import 'package:flutter_app/bloc/auth_event.dart';
import 'package:flutter_app/bloc/auth_state.dart';
import 'package:flutter_app/data/auth_service.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:flutter_app/screens/login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final authService = AuthService();
  runApp(MyApp(authService));
}

class MyApp extends StatelessWidget{
  final AuthService authService;
  const MyApp(this.authService, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(authService)..add(CheckLoginStatus()),
      child: MaterialApp(
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state){
            if (state is AuthAuthenticated) return HomeScreen();
            if (state is AuthUnauthenticated || state is AuthInitial) return LoginScreen();
            return Center(child: CircularProgressIndicator());
          }
        )
      )
    );
  }
}
