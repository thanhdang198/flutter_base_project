import 'package:flutter/foundation.dart';
import 'package:flutter_sample/data/models/register_data_model.dart';
import 'package:flutter_sample/core/failure/failure.dart';
import 'package:flutter_appauth_platform_interface/src/authorization_token_response.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_sample/domains/repositories/authentication_repository.dart';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:io';

import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import 'package:flutter_sample/extensions/dio_extension.dart';
import '../../constants/constants.dart';
import '../../constants/dio_refresh_token.dart';
import '../../core/dependency_injection/app_context.dart';
import '../../core/failure/api_server_failuer.dart';
import '../../core/failure/api_timeout_failure.dart';
import '../../core/failure/exeption_failure.dart';
import '../models/authorization_token_response_model.dart';

class AuthenticationApiRepositories implements AuthenticationRepository {
  late Dio _dio;
  String? accessToken;
  String? refreshToken;
  final String _baseUrl = authenticationBaseUrl;
  AuthenticationApiRepositories() {
    _dio = Dio(BaseOptions(baseUrl: _baseUrl));

    if (kDebugMode) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
      _dio.interceptors
          .add(DioLoggingInterceptor(level: Level.body, compact: false));
    }
    accessToken = AppContext().getAccessToken;
    refreshToken = AppContext().getRefreshToken;
    refreshAccessTokenFunction(_dio, accessToken);
  }

  @override
  Future<Either<Failure, AuthorizationTokenResponse>> loginWithUserName(
      {required String userName, required String password}) async {
    try {
      var res = await _dio
          .post('login', data: {'userName': userName, 'password': password});

      if (res.validate()) {
        Map data = json.decode(res.data['data']);
        AuthorizationTokenResponse authorizationTokenResponse =
            AuthorizationTokenResponseModel.fromMap(data);
        return Right(authorizationTokenResponse);
      } else if (res.getMessage() != null) {
        return Left(ApiServerFailure(res.getMessage().toString()));
      }
      return const Left(ApiServerFailure('Có lỗi xảy ra'));
    } on DioError catch (ex) {
      if (ex.type == DioErrorType.receiveTimeout) {
        return Left(ApiTimeOutFailure());
      } else {
        return Left(ExceptionFailure(ex));
      }
    }
  }

  @override
  Future<Either<Failure, bool>> changePassword(
      {required String userId, required String password}) {
    // TODO: implement changePassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> forgotPassword(String email) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, AuthorizationTokenResponse>> loginWithApple(
      String token) {
    // TODO: implement loginWithApple
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, AuthorizationTokenResponse>> loginWithFacebook(
      String token) {
    // TODO: implement loginWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, AuthorizationTokenResponse>> loginWithGoogle(
      String token) {
    // TODO: implement loginWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> logout(String refreshToken) {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> refreshAccessToken() {
    // TODO: implement refreshAccessToken
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, RegisterDataModel>> register(
      RegisterDataModel params) {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, dynamic>> verifyEmail(String email) {
    // TODO: implement verifyEmail
    throw UnimplementedError();
  }
}
