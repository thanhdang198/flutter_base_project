library dio_handle;

import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_sample/extensions/dio_extension.dart';
import '../core/dependency_injection/app_context.dart';

refreshAccessTokenFunction(Dio dio, String? token) {
  int retryCount = 0;
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (request, handler) {
        if (token != null && token != '') {
          request.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(request);
      },
      onError: (e, handler) async {
        if ((e.response?.statusCode == 401 || e.response?.statusCode == 403) &&
            retryCount < 2 &&
            AppContext().isUserAuthenticated()) {
          try {
            print(AppContext().getRefreshToken);
            print(AppContext().getAccessToken);
            await Dio()
                .post(
              "YOUR REFRESH TOKEN URL HERE",
              data: jsonEncode(AppContext().getRefreshToken),
            )
                .then((value) async {
              retryCount++;
              if (value.validate()) {
                // Map data = Map.from(value.data['data']);
                // print(data);
                Map data = jsonDecode((value.data['data'] ?? ''));
                AuthorizationTokenResponse authorizationTokenResponse =
                    AuthorizationTokenResponse(
                        data['access_token'],
                        data['refresh_token'],
                        DateTime.now().add(const Duration(hours: 10)),
                        '',
                        data['token_type'],
                        data['scope']?.split(' ') ?? [],
                        null,
                        {'refresh_expires_in': data['refresh_expires_in']});
                AppContext().setAuthToken(authorizationTokenResponse);
                token = data['access_token'];
                e.requestOptions.headers["Authorization"] =
                    "Bearer ${token ?? ''}";
                final opts = Options(
                    method: e.requestOptions.method,
                    headers: e.requestOptions.headers);
                final cloneReq = await dio.request(e.requestOptions.path,
                    options: opts,
                    data: e.requestOptions.data,
                    queryParameters: e.requestOptions.queryParameters);

                return handler.resolve(cloneReq);
              }
            });
            // return _dio;
          } on DioError catch (e, st) {
            handler.next(e);
          }
          try {
            handler.next(e);
          } catch (e) {}
        }
        try {
          handler.next(e);
        } catch (e) {}
      },
    ),
  );
}
