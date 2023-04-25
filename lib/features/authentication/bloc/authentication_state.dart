part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  final UserDataModel? userDataModel;
  final AuthorizationTokenResponse? authorizationTokenResponse;
  const AuthenticationState(
      {this.authorizationTokenResponse, this.userDataModel});

  @override
  List<Object?> get props => [userDataModel];
}

class AuthenticationStateInitial extends AuthenticationState {}

class AuthenticationStateUserLoginSuccess extends AuthenticationState {
  final AuthorizationTokenResponse authorizationTokenResponse;
  const AuthenticationStateUserLoginSuccess(this.authorizationTokenResponse)
      : super(authorizationTokenResponse: authorizationTokenResponse);
}

class AuthenticationStateUserLoginFailure extends AuthenticationState {}

class AuthenticationStateLoading extends AuthenticationState {}
