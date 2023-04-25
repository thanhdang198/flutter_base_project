import 'package:flutter_sample/core/failure/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_sample/core/no_params.dart';
import 'package:flutter_sample/core/use_case.dart';
import 'package:flutter_sample/data/models/authorization_token_response_model.dart';
import 'package:flutter_sample/domains/repositories/authentication_repository.dart';

import 'package:flutter_appauth/flutter_appauth.dart';

class UserLoginParams extends NoParams {
  final String userName;
  final String password;

  UserLoginParams({required this.userName, required this.password});
}

class LoginWithAccountUseCase
    extends UseCase<UserLoginParams, AuthorizationTokenResponse> {
  final AuthenticationRepository repository;

  LoginWithAccountUseCase(this.repository);

  @override
  Future<Either<Failure, AuthorizationTokenResponse>> call(
      UserLoginParams params) {
    return repository.loginWithUserName(
        userName: params.userName, password: params.password);
  }
}
