import 'dart:convert';

UploadVideoReponse uploadVideoReponseFromJson(String str) => UploadVideoReponse.fromJson(json.decode(str));

String uploadVideoReponseToJson(UploadVideoReponse data) => json.encode(data.toJson());

class UploadVideoReponse {
  String success;
  String redirectUrl;
  String transcript;
  String videoUrl;
  int videoPostRouting;

  UploadVideoReponse({
    required this.success,
    required this.redirectUrl,
    required this.transcript,
    required this.videoUrl,
    required this.videoPostRouting,
  });

  factory UploadVideoReponse.fromJson(Map<String, dynamic> json) => UploadVideoReponse(
    success: json["success"],
    redirectUrl: json["redirect_url"],
    transcript: json["transcript"],
    videoUrl: json["video_url"],
    videoPostRouting: json["video_post_routing"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "redirect_url": redirectUrl,
    "transcript": transcript,
    "video_url": videoUrl,
    "video_post_routing": videoPostRouting,
  };
}
