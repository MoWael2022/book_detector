import '../../domin/entites/User.dart';

class UserModel extends User {
  UserModel({
    required super.fName,
    required super.message,
    required super.lName,
    //required super.expiresOn,
    required super.isAuthenticated,
    //required super.refreshTokenExpiration,
    required super.role,
    required super.token,
    required super.id,
    required super.userName,
    required super.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      message: json['message'],
      isAuthenticated: json['isAuthenticated'],
      //refreshTokenExpiration: json['refreshTokenExpiration'],
      fName: json['fname'],
      lName: json['lname'],
      //expiresOn: json['expiresOn'],
      id: json['id'],
      userName: json['username'],
      email: json['email'],
      role: json['roles'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fname': fName,
      'lname': lName,
      'id': id,
      'userName': userName,
      'email': email,

    };
  }
}
