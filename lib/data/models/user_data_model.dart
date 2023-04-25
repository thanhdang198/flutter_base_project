import '../../domains/entities/user_data.dart';

class UserDataModel extends UserData {
  UserDataModel(
      {super.avatar,
      super.birthday,
      super.createdAt,
      super.email,
      super.userName});
  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'birthday': birthday,
      'createdAt': createdAt,
      'avatar': avatar,
      'email': email
    };
  }

  factory UserDataModel.fromMap(Map json) {
    return UserDataModel(
        userName: json['userName'],
        birthday: json['birthday'],
        createdAt: json['createdAt'],
        avatar: json['avatar'],
        email: json['email']);
  }
}
