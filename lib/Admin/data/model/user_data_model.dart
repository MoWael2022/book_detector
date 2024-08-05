import 'package:khaltabita/Admin/domin/entites/user_data_entites.dart';

class UserDataModel extends UserDataEntities {
  UserDataModel(
      {required super.id,
      required super.fname,
      required super.lnmae,
      required super.mail,
      required super.userName});

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
        id: json["id"],
        fname: json["fname"],
        lnmae: json["lname"],
        mail: json["mail"],
        userName: json["userName"]);
  }
}
