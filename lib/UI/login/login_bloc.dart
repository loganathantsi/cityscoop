import 'package:CityScoop/api/repository.dart';
import 'package:CityScoop/app/components/utilities.dart';
import 'package:CityScoop/constants/strings.dart';
import 'package:CityScoop/model/login_request_model.dart';
import 'package:CityScoop/model/login_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState(usernameController: TextEditingController(), passwordController: TextEditingController(), isRememberMe: false)) {
    on<LoginApiEvent>(_onLoginApiEvent);
    on<LoginRememberMeEvent>(_onLoginRememberMeEvent);
  }

  void _onLoginApiEvent(LoginApiEvent event, Emitter<LoginState> emit) async {

    emit(state.copyWith(currentState: LoginStatus.loading, usernameController: event.usernameController, passwordController: event.passwordController));

    LoginRequest loginRequest = LoginRequest();
    loginRequest.username = event.usernameController.text;
    loginRequest.password = event.passwordController.text;

    final LoginResponse? loginResponse = await CityScoopRepository().callLoginApi(loginRequest);

    if (loginResponse != null) {
      Utilities.setStringPreference(Strings.accessToken, loginResponse.token);
      Utilities.setBoolPreference(Strings.loginSuccess, true);
      emit(state.copyWith(currentState: LoginStatus.success, loginResponse: loginResponse));
    } else {
      emit(state.copyWith(currentState: LoginStatus.error, error: 'Invalid username and password'));
    }
  }

  void _onLoginRememberMeEvent(LoginRememberMeEvent event, Emitter<LoginState> emit) {
    if(event.rememberMe) {
      Utilities.setStringPreference(Strings.username, state.usernameController.text);
      Utilities.setStringPreference(Strings.password, state.passwordController.text);
    } else {
      Utilities.setStringPreference(Strings.username, "");
      Utilities.setStringPreference(Strings.password, "");
    }
    emit(state.copyWith(isRememberMe: event.rememberMe));
  }

}


