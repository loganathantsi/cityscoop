import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginStart>(_onLoginStart);
  }

  void _onLoginStart(LoginStart event, Emitter<LoginState> emit) {
    emit(LoginStarted());
  }

}
