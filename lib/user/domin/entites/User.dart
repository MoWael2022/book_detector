class User {
  String fName;
  String lName;
  String? profileimg;
  String id;
  String userName;
  String normalizedUserName;
  String email;
  String normalizedEmail;
  bool emailConfirmed;
  String passwordHash;
  String securityStamp;
  String concurrencyStamp;
  String? phoneNumber;
  bool? phoneNumberConfirmed;
  bool? twoFactorEnabled;
  String? lockoutEnd;
  bool? lockoutEnabled;
  int? accessFailedCount;

  User(
      {required this.fName,
        required this.lName,
        required this.profileimg,
        required this.id,
        required this.userName,
        required this.normalizedUserName,
        required this.email,
        required this.normalizedEmail,
        required this.emailConfirmed,
        required this.passwordHash,
        required this.securityStamp,
        required this.concurrencyStamp,
        this.phoneNumber,
        this.phoneNumberConfirmed,
        this.twoFactorEnabled,
        this.lockoutEnd,
        this.lockoutEnabled,
        this.accessFailedCount});


}
