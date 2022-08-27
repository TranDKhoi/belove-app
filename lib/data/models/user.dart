class User {
  String? userId;
  String? partnerId;
  User? partner;
  String? email;
  String? password;
  String? name;
  DateTime? birthday;
  int? gender;
  String? avatar;

  User({
    this.userId,
    this.partnerId,
    this.partner,
    this.email,
    this.password,
    this.gender,
    this.name,
    this.birthday,
    this.avatar,
  });
}
