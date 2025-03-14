import 'dart:convert';

NotificationTokenResponse notificationTokenResponseFromJson(String str) => NotificationTokenResponse.fromJson(json.decode(str));

String notificationTokenResponseToJson(NotificationTokenResponse data) => json.encode(data.toJson());

class NotificationTokenResponse {
  bool success;
  String notificationToken;
  String deviceType;

  NotificationTokenResponse({
    required this.success,
    required this.notificationToken,
    required this.deviceType,
  });

  factory NotificationTokenResponse.fromJson(Map<String, dynamic> json) => NotificationTokenResponse(
    success: json["success"],
    notificationToken: json["notification_token"],
    deviceType: json["device_type"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "notification_token": notificationToken,
    "device_type": deviceType,
  };
}
