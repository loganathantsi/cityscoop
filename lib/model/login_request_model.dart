class LoginRequest{
  String? username;
  String? password;

  LoginRequest({
    this.username,
    this.password
  });

  Map <String, dynamic> toDatabaseJson() => {
    "username": username,
    "password": password,
  };
}