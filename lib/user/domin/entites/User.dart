class User {
  String fName;
  String lName;
  String email;
  String userName;
  String message;
  //String? profileImg;
  String token;
  String id;
  bool isAuthenticated;
  List<dynamic> role;
  //String expiresOn;
  //String refreshTokenExpiration;

  User({

    required this.fName,
    required this.message,
    required this.lName,
    //required this.expiresOn,
    required this.isAuthenticated,
    //required this.refreshTokenExpiration,
    required this.role,
    required this.token,
    required this.id,
    required this.userName,
    required this.email,

  });
}
