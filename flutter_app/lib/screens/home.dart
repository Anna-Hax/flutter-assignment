import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/auth_bloc.dart';
import 'package:flutter_app/bloc/auth_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(LogoutRequested());
            },
          )
        ]
      ),
      body: Center(child: Text("Welcome!")),
    );
  }
}