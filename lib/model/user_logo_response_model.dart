import 'dart:convert';

UserLogoResponse userLogoResponseFromJson(String str) => UserLogoResponse.fromJson(json.decode(str));

String userLogoResponseToJson(UserLogoResponse data) => json.encode(data.toJson());

class UserLogoResponse {
  String status;
  String userlogoBase64;
  String userlogoUrl;

  UserLogoResponse({
    required this.status,
    required this.userlogoBase64,
    required this.userlogoUrl,
  });

  factory UserLogoResponse.fromJson(Map<String, dynamic> json) => UserLogoResponse(
    status: json["status"],
    userlogoBase64: json["userlogo_base64"],
    userlogoUrl: json["userlogo_url"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "userlogo_base64": userlogoBase64,
    "userlogo_url": userlogoUrl,
  };
}
