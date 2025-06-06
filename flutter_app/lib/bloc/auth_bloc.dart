import 'package:flutter_app/bloc/auth_event.dart';
import 'package:flutter_app/bloc/auth_state.dart';
import 'package:flutter_app/data/auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;

  AuthBloc(this.authService) : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try{
        final authModel = await authService.login(
          email: event.email,
          password: event.password,
        );
        emit(AuthAuthenticated(authModel.email));
      } catch (error) {
        emit(AuthError("Login failed"));
      }
    });

    on<SignupRequested>((event, emit) async {
      emit(AuthLoading());
      try{
        final authModel = await authService.login(
          email: event.email,
          password: event.password,
        );
        emit(AuthAuthenticated(authModel.email));
      } catch (error) {
        emit(AuthError("Signup failed"));
      }
    });

    on<LogoutRequested>((event, emit) async {
      await authService.logout();
      emit(AuthUnauthenticated());
    });

    on<CheckLoginStatus>((event, emit) async {
      final loggedIn = await authService.isLoggedIn();
      if(loggedIn){
        final token = await authService.getToken();
        emit(AuthAuthenticated(token ?? ""));
      } else {
        emit(AuthUnauthenticated());
      }
    });
  }
}