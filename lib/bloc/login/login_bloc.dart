import 'package:bloc_practice/repository/login_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginRepository loginRepository = LoginRepository();
  LoginBloc() : super(const LoginState()) {
    on<EmailChanged>(_emailChanged);
    on<PasswordChanged>(_passwordChange);
    on<LoginApi>(_loginApi);
  }

  void _emailChanged(EmailChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _passwordChange(PasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _loginApi(LoginApi event, Emitter<LoginState> emit) async {
    emit(state.copyWith(loginStatus: LoginStatus.loading));
    await loginRepository
        .login(state.email, state.password)
        .then((value) {
          emit(
            state.copyWith(loginStatus: LoginStatus.success, message: value),
          );
        })
        .onError((error, stackTrace) {
          emit(
            state.copyWith(
              loginStatus: LoginStatus.error,
              message: error.toString(),
            ),
          );
        });
    emit(state.copyWith(loginStatus: LoginStatus.initial));
  }
}
