import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/auth_bloc.dart';
import 'package:flutter_app/bloc/auth_event.dart';
import 'package:flutter_app/bloc/auth_state.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget{
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state){
          if (state is AuthAuthenticated){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
          }
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message),));
          }
        },
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(controller: emailCtrl, decoration: InputDecoration(labelText: "Email")),
              TextField(controller: emailCtrl, obscureText: true, decoration: InputDecoration(labelText: "Password")),
              ElevatedButton(
                onPressed: (){
                  context.read<AuthBloc>().add(LoginRequested(emailCtrl.text, passCtrl.text));
                }, 
                child: Text("Login"),
              )
            ],
          ),
        )
      )
    );
  }
}