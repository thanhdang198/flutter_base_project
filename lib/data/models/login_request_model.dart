import 'package:flutter_sample/domains/entities/login_request.dart';

class LoginRequestModel extends LoginRequestData {
  LoginRequestModel({required super.account, required super.password});
  Map<String, dynamic> toMap() {
    return {'account': super.account, 'password': super.password};
  }
  
}
