import 'dart:convert';

PostPublishNotifications postPublishNotificationsFromJson(String str) => PostPublishNotifications.fromJson(json.decode(str));

String postPublishNotificationsToJson(PostPublishNotifications data) => json.encode(data.toJson());

class PostPublishNotifications {
  bool success;
  bool error;
  int totalCount;
  int unreadCount;
  List<Datum> data;

  PostPublishNotifications({
    required this.success,
    required this.error,
    required this.totalCount,
    required this.unreadCount,
    required this.data,
  });

  factory PostPublishNotifications.fromJson(Map<String, dynamic> json) => PostPublishNotifications(
    success: json["success"],
    error: json["error"],
    totalCount: json["total_count"],
    unreadCount: json["unread_count"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "error": error,
    "total_count": totalCount,
    "unread_count": unreadCount,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String title;
  String message;
  String postLink;
  bool tapAction;
  String type;
  String id;
  String read;
  DateTime dateCreated;
  String timestamp;
  String videoLink;

  Datum({
    required this.title,
    required this.message,
    required this.postLink,
    required this.tapAction,
    required this.type,
    required this.id,
    required this.read,
    required this.dateCreated,
    required this.timestamp,
    required this.videoLink,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    title: json["title"],
    message: json["message"],
    postLink: json["post_link"],
    tapAction: json["tap_action"],
    type: json["type"],
    id: json["id"],
    read: json["read"],
    dateCreated: DateTime.parse(json["date_created"]),
    timestamp: json["timestamp"],
    videoLink: json["video_link"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "message": message,
    "post_link": postLink,
    "tap_action": tapAction,
    "type": type,
    "id": id,
    "read": read,
    "date_created": dateCreated.toIso8601String(),
    "timestamp": timestamp,
    "video_link": videoLink,
  };
}
