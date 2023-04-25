part of 'authentication_bloc.dart';

class AuthenticationEvent {}

class AuthenticationEventUserLogin extends AuthenticationEvent {
  final UserLoginParams userLoginParams;

  AuthenticationEventUserLogin({required this.userLoginParams});
}

class AuthenticationEventUserRegister extends AuthenticationEvent {
  final RegisterDataModel registerDataModel;

  AuthenticationEventUserRegister(this.registerDataModel);
}

class AuthenticationEventUserLogout extends AuthenticationEvent {}
