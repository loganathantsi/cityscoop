part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginApiEvent extends LoginEvent {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  LoginApiEvent({ required this.usernameController, required this.passwordController});
}

class LoginRememberMeEvent extends LoginEvent {
  final bool rememberMe;
  LoginRememberMeEvent({ required this.rememberMe });
}