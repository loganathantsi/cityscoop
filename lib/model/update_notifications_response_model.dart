import 'dart:convert';

UpdateNotification updateNotificationsFromJson(String str) => UpdateNotification.fromJson(json.decode(str));

String updateNotificationsToJson(UpdateNotification data) => json.encode(data.toJson());

class UpdateNotification {
  bool success;
  bool error;

  UpdateNotification({
    required this.success,
    required this.error,
  });

  factory UpdateNotification.fromJson(Map<String, dynamic> json) => UpdateNotification(
    success: json["success"],
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "error": error,
  };
}
