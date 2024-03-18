class CategoryNameEntities {
  String categoryName;

  CategoryNameEntities({required this.categoryName});
}

class BookNameEntities {
  String bookName;

  BookNameEntities({required this.bookName});
}

class UserInputRegisterEntities {
  String email;

  String fName;

  String lName;

  String password;

  String confirmPassword;

  UserInputRegisterEntities(
      {required this.email,
      required this.confirmPassword,
      required this.fName,
      required this.lName,
      required this.password});
}
