import '../../domin/entites/category_name_entites.dart';

class UserInputModel extends UserInputRegisterEntities {
  UserInputModel(
      {required super.email,
      required super.confirmPassword,
      required super.fName,
      required super.lName,
      required super.password});

   Map<String, String> toMap() {
    return {
      "Email": email,
      "Fname": fName,
      "Lname": lName,
      "Password": password,
      "ConfirmPassword": confirmPassword,
    };
  }
}
