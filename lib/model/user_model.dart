import '../core/utils/constance.dart';

class User {
  int? userId;

  String? userName, email, password;

  User(
      {this.userId,
      required this.email,
      required this.password,
      required this.userName});

  factory User.fomJson(Map<dynamic, dynamic> map) => User(
        userId: map[Constance.userId],
        userName: map[Constance.userName],
        email: map[Constance.userEmail],
        password: map[Constance.userPassword],
      );

  toJson() {
    return {
      Constance.userId: userId.toString(),
      Constance.userName: userName,
      Constance.userEmail: email,
      Constance.userPassword: password,
    };
  }
}
