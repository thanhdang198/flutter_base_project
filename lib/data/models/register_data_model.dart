import 'package:flutter_sample/domains/entities/register.dart';

class RegisterDataModel extends RegisterData {
  RegisterDataModel(
      {super.userName,
      super.password,
      super.emailVerified,
      super.enabled,
      super.firstName,
      super.lastName,
      super.email});
  toMap() {
    return {
      "userName": userName,
      "password": password,
      "lastName": lastName,
      'email': email
    };
  }

  factory RegisterDataModel.fromMap(Map json) {
    return RegisterDataModel(
        userName: json['userName'],
        password: json['password'],
        emailVerified: json['emailVerified'],
        enabled: json['enabled'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email']);
  }
}
