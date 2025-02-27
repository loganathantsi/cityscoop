import 'dart:convert';

RegisterAppSignUp registerAppSignUpFromJson(String str) => RegisterAppSignUp.fromJson(json.decode(str));

String registerAppSignUpToJson(RegisterAppSignUp data) => json.encode(data.toJson());

class RegisterAppSignUp {
  bool success;
  String regToken;

  RegisterAppSignUp({
    required this.success,
    required this.regToken,
  });

  factory RegisterAppSignUp.fromJson(Map<String, dynamic> json) => RegisterAppSignUp(
    success: json["success"],
    regToken: json["reg_token"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "reg_token": regToken,
  };
}
