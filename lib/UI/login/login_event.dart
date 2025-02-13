part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginSuccessEvent extends LoginEvent {}

class LoginApiEvent extends LoginEvent {
  final String username;
  final String password;
  LoginApiEvent({ required this.username, required this.password });
}