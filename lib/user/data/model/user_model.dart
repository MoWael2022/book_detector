import '../../domin/entites/User.dart';

class UserModel extends User {
  UserModel(
      {required super.fName,
      required super.lName,
      required super.profileimg,
      required super.id,
      required super.userName,
      required super.normalizedUserName,
      required super.email,
      required super.normalizedEmail,
      required super.emailConfirmed,
      required super.passwordHash,
      required super.securityStamp,
      required super.concurrencyStamp});



  factory UserModel.fromJson(Map<String, dynamic> json) {
      return UserModel(
          fName : json['fname'],
          lName : json['lname'],
          profileimg : json['profileimg'],
          id : json['id'],
          userName : json['userName'],
          normalizedUserName : json['normalizedUserName'],
          email : json['email'],
          normalizedEmail : json['normalizedEmail'],
          emailConfirmed : json['emailConfirmed'],
          passwordHash : json['passwordHash'],
          securityStamp : json['securityStamp'],
          concurrencyStamp : json['concurrencyStamp'],
          );

  }

  Map<String, dynamic> toJson() {
      return {
          'fname': fName,
          'lname': lName,
          'profileimg': profileimg,
          'id': id,
          'userName': userName,
          'normalizedUserName': normalizedUserName,
          'email': email,
          'normalizedEmail': normalizedEmail,
          'emailConfirmed': emailConfirmed,
          'passwordHash': passwordHash,
          'securityStamp': securityStamp,
          'concurrencyStamp': concurrencyStamp,
      };
  }
}
