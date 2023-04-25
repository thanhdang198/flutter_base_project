import 'package:flutter_sample/core/failure/failure.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter_appauth/flutter_appauth.dart';

import '../../data/models/register_data_model.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, AuthorizationTokenResponse>> loginWithUserName(
      {required String userName, required String password});
  Future<Either<Failure, AuthorizationTokenResponse>> loginWithApple(
      String token);
  Future<Either<Failure, AuthorizationTokenResponse>> loginWithGoogle(
      String token);
  Future<Either<Failure, AuthorizationTokenResponse>> loginWithFacebook(
      String token);
  Future<Either<Failure, bool>> logout(String refreshToken);
  Future<Either<Failure, bool>> refreshAccessToken();
  Future<Either<Failure, RegisterDataModel>> register(RegisterDataModel params);

  Future<Either<Failure, dynamic>> verifyEmail(String email);
  Future<Either<Failure, bool>> changePassword(
      {required String userId, required String password});
  Future<Either<Failure, bool>> forgotPassword(String email);
}
