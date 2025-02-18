part of 'login_bloc.dart';

class LoginState {
  final LoginStatus? currentState;
  final String? error;
  final LoginResponse? loginResponse;
  TextEditingController usernameController;
  TextEditingController passwordController;
  bool isRememberMe = false;

  LoginState({
    this.currentState,
    this.error,
    this.loginResponse,
    required this.usernameController,
    required this.passwordController,
    required this.isRememberMe,
  });

  LoginState copyWith({
    LoginStatus? currentState,
    String? error,
    LoginResponse? loginResponse,
    TextEditingController? usernameController,
    TextEditingController? passwordController,
    bool? isRememberMe,
  }) {
    return LoginState(
      currentState: currentState ?? this.currentState,
      error: error,
      loginResponse: loginResponse ?? this.loginResponse,
      usernameController: usernameController ?? this.usernameController,
      passwordController: passwordController ?? this.passwordController,
      isRememberMe: isRememberMe ?? this.isRememberMe,
    );
  }
}

enum LoginStatus {
  loading,
  success,
  error
}