class InputLoginData {
  InputLoginData({required this.email, required this.password});

  String email;
  String password;

  Map<String, String> toMap() {
    return {
      "Email": email,
      "Password": password,
    };
  }
}
