import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_sample/core/dependency_injection/app_context.dart';
import 'package:flutter_sample/data/models/register_data_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_sample/data/models/user_data_model.dart';
import 'package:flutter_sample/data/repositories/authentication_repositories.dart';

import 'package:flutter_appauth/flutter_appauth.dart';
import '../../../domains/use_case/authentication_use_case.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationStateInitial()) {
    on<AuthenticationEventUserLogin>(_onAuthenticationEventUserLogin);
    on<AuthenticationEventUserRegister>(_onAuthenticationEventUserRegister);
    on<AuthenticationEventUserLogout>(_onAuthenticationEventUserLogout);
  }
  _onAuthenticationEventUserLogin(AuthenticationEventUserLogin event,
      Emitter<AuthenticationState> emit) async {
    EasyLoading.show();
    emit(AuthenticationStateLoading());
    var authResponse =
        await LoginWithAccountUseCase(AuthenticationApiRepositories())
            .call(event.userLoginParams);
    EasyLoading.dismiss();
    authResponse.fold((l) {
      emit(AuthenticationStateUserLoginFailure());
    }, (r) {
      AppContext().setAuthToken(r);
      emit(AuthenticationStateUserLoginSuccess(r));
    });
  }

  _onAuthenticationEventUserRegister(AuthenticationEventUserRegister event,
      Emitter<AuthenticationState> emit) {}
  _onAuthenticationEventUserLogout(
      AuthenticationEventUserLogout event, Emitter<AuthenticationState> emit) {}
}
