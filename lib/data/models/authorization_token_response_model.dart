import 'package:flutter_appauth_platform_interface/src/authorization_token_response.dart';

class AuthorizationTokenResponseModel extends AuthorizationTokenResponse {
  AuthorizationTokenResponseModel(
      super.accessToken,
      super.refreshToken,
      super.accessTokenExpirationDateTime,
      super.idToken,
      super.tokenType,
      super.scopes,
      super.authorizationAdditionalParameters,
      super.tokenAdditionalParameters);

  factory AuthorizationTokenResponseModel.fromMap(Map data) {
    return AuthorizationTokenResponseModel(
        data['access_token'],
        data['refresh_token'],
        DateTime.now().add(const Duration(hours: 10)),
        '',
        data['token_type'],
        data['scope']?.split(' '),
        null,
        {'refresh_expires_in': data['refresh_expires_in']});
  }
}
