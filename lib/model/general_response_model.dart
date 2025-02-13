import 'dart:convert';

GeneralResponse generalResponseFromJson(String str) => GeneralResponse.fromJson(json.decode(str));
String generalResponseToJson(GeneralResponse data) => json.encode(data.toJson());

class GeneralResponse {
  String code;
  String message;
  Data data;

  GeneralResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  factory GeneralResponse.fromJson(Map<String, dynamic> json) => GeneralResponse(
    code: json["code"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  int status;

  Data({
    required this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
  };
}
