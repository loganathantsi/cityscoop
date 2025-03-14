import 'dart:convert';

UploadBrandResponse uploadBrandResponseFromJson(String str) => UploadBrandResponse.fromJson(json.decode(str));

String uploadBrandResponseToJson(UploadBrandResponse data) => json.encode(data.toJson());

class UploadBrandResponse {
  String avatarUrl;
  String status;

  UploadBrandResponse({
    required this.avatarUrl,
    required this.status,
  });

  factory UploadBrandResponse.fromJson(Map<String, dynamic> json) => UploadBrandResponse(
    avatarUrl: json["avatar-url"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "avatar-url": avatarUrl,
    "status": status,
  };
}
