import 'dart:convert';

import 'package:dio/dio.dart';

extension DioExtension on Response {
  validate() {
    Response response = this;
    return response.statusCode == 200 &&
        (response.data['code'] == 'OK' || response.data['code'] == 'SUCCESS');
  }

  authorizationValidate() {
    Response response = this;
    return response.statusCode == 200 &&
        json.decode(response.data)['access_token'] != null;
  }

  getMessage() {
    Response response = this;
    return response.data['message'];
  }
}
