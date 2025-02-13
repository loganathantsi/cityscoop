import 'package:CityScoop/api/repository.dart';
import 'package:CityScoop/app/components/utilities.dart';
import 'package:CityScoop/constants/strings.dart';
import 'package:CityScoop/model/login_request_model.dart';
import 'package:CityScoop/model/login_response_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState()) {
    on<LoginSuccessEvent>(_onLoginSuccessEvent);
    on<LoginApiEvent>(_onLoginApiEvent);
  }

  void _onLoginSuccessEvent(LoginSuccessEvent event, Emitter<LoginState> emit) {
    emit(LoginSuccessState());
  }

  void _onLoginApiEvent(LoginApiEvent event, Emitter<LoginState> emit) async {
    LoginRequest loginRequest = LoginRequest();
    loginRequest.username = event.username;
    loginRequest.password = event.password;

    final LoginResponse? loginResponse = await CityScoopRepository().callLoginApi(loginRequest);

    if (loginResponse != null) {
      Utilities.setStringPreference(Strings.accessToken, loginResponse.token);
      Utilities.setBoolPreference(Strings.loginSuccess, true);
      emit(LoginSuccessState());
    }
  }

}
