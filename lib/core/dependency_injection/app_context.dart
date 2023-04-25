import 'dart:convert';

import 'package:flutter_appauth/flutter_appauth.dart';

import '../../constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppContext {
  static final AppContext _singleton = AppContext._internal();
  final _sharedPreference = SharedPreferences.getInstance();
  final _secureStorage = const FlutterSecureStorage();
  factory AppContext() {
    return _singleton;
  }
  AppContext._internal();

  AuthorizationTokenResponse? _authorizationTokenResponse;

  Future<void> setAuthToken(AuthorizationTokenResponse token) async {
    await _saveTokenToDisk(token);
    _authorizationTokenResponse = token;
  }

  Future<void> logoutAndRemoveToken() async {
    _authorizationTokenResponse = null;
    await (await _sharedPreference).remove(authenticationTokenResKey);
    //save to disk
  }

  String? get getAccessToken {
    if (_authorizationTokenResponse == null) return null;
    if (!isUserAuthenticated()) return null;
    return _authorizationTokenResponse!.accessToken;
  }

  String? get getRefreshToken {
    if (_authorizationTokenResponse == null) return null;
    if (!isUserAuthenticated()) return null;
    return _authorizationTokenResponse!.refreshToken;
  }

  String? get getIdToken {
    if (_authorizationTokenResponse == null) return null;
    if (!isUserAuthenticated()) return null;
    return _authorizationTokenResponse!.idToken;
  }

  Future<AuthorizationTokenResponse?> getTokenFromDisk() async {
    String? value = await _secureStorage.read(key: authenticationTokenResKey);

    if (value == null) return null;
    return _decodeToken(jsonDecode(value));
  }

  Future _saveTokenToDisk(AuthorizationTokenResponse data) async {
    var text = _encodeToken(data);

    await _secureStorage.write(key: authenticationTokenResKey, value: text);
  }

  AuthorizationTokenResponse? _decodeToken(dynamic formData) {
    Map data = jsonDecode(jsonEncode(formData));
    if (data != null) {
      var accessToken = data['accessToken'].toString();

      var accessTokenExpirationDateTime =
          DateTime.parse(data['accessTokenExpirationDateTime']);
      var idToken = data['idToken'].toString();
      var refreshToken = data['refreshToken'].toString();
      var scopes =
          (List.from(data['scopes'] ?? [])).map((e) => e.toString()).toList();
      //var authorizationAdditionalParameters= jsonDecode( data['authorizationAdditionalParameters']) as Map<String,dynamic>;
      //var tokenAdditionalParameters= jsonDecode(data['tokenAdditionalParameters']) as Map<String,dynamic>;
      var tokenType = data['tokenType'].toString();
      var tokenAdditionalParameters =
          Map<String, dynamic>.from(data['tokenAdditionalParameters']);
      return AuthorizationTokenResponse(
          accessToken,
          refreshToken,
          accessTokenExpirationDateTime,
          idToken,
          tokenType,
          scopes,
          {},
          tokenAdditionalParameters);
    }
    return null;
  }

  String _encodeToken(AuthorizationTokenResponse? data) {
    var map = {};
    map['accessToken'] = data?.accessToken;
    map['authorizationAdditionalParameters'] =
        data?.authorizationAdditionalParameters;
    map['accessTokenExpirationDateTime'] =
        data?.accessTokenExpirationDateTime?.toIso8601String();
    map['idToken'] = data?.idToken;
    map['refreshToken'] = data?.refreshToken;
    map['scopes'] = (data?.scopes ?? []);
    map['tokenAdditionalParameters'] = (data?.tokenAdditionalParameters);
    map['tokenType'] = data?.tokenType;

    return jsonEncode(map);
  }

  bool isUserAuthenticated() {
    if (_authorizationTokenResponse == null) {
      return false;
    } else {
      int inTime = 0;
      //check valid
      if (_authorizationTokenResponse!.refreshToken == null) {
        return false;
      }
      if (_authorizationTokenResponse!.accessToken == null) return false;
      if (_authorizationTokenResponse!
              .authorizationAdditionalParameters?['refresh_expires_in'] !=
          null) {
        inTime = DateTime.tryParse(_authorizationTokenResponse!
                    .authorizationAdditionalParameters?['refresh_expires_in'])
                ?.difference(DateTime.now())
                .inMinutes ??
            0;
      } else {
        inTime = _authorizationTokenResponse!.accessTokenExpirationDateTime!
            .difference(DateTime.now())
            .inMinutes;
      }
      if (inTime < 1) {
        return false;
      } else {
        return true;
      }
    }
  }
}
