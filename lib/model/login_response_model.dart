import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  String token;
  String userEmail;
  String userNicename;
  String userDisplayName;
  bool registeredWithApp;
  String gmtOffset;
  int blogId;
  String blogUrl;
  String blogCity;
  String blogState;
  String cscAppVersion;
  String cscProjectBoardUrl;
  String csDashboardUrl;
  String profileEditUrl;
  List<dynamic> userGroups;

  LoginResponse({
    required this.token,
    required this.userEmail,
    required this.userNicename,
    required this.userDisplayName,
    required this.registeredWithApp,
    required this.gmtOffset,
    required this.blogId,
    required this.blogUrl,
    required this.blogCity,
    required this.blogState,
    required this.cscAppVersion,
    required this.cscProjectBoardUrl,
    required this.csDashboardUrl,
    required this.profileEditUrl,
    required this.userGroups,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    token: json["token"],
    userEmail: json["user_email"],
    userNicename: json["user_nicename"],
    userDisplayName: json["user_display_name"],
    registeredWithApp: json["registered_with_app"],
    gmtOffset: json["gmt_offset"],
    blogId: json["blog_id"],
    blogUrl: json["blog_url"],
    blogCity: json["blog_city"],
    blogState: json["blog_state"],
    cscAppVersion: json["csc_app_version"],
    cscProjectBoardUrl: json["csc_project_board_url"],
    csDashboardUrl: json["cs_dashboard_url"],
    profileEditUrl: json["profile_edit_url"],
    userGroups: List<dynamic>.from(json["user_groups"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "user_email": userEmail,
    "user_nicename": userNicename,
    "user_display_name": userDisplayName,
    "registered_with_app": registeredWithApp,
    "gmt_offset": gmtOffset,
    "blog_id": blogId,
    "blog_url": blogUrl,
    "blog_city": blogCity,
    "blog_state": blogState,
    "csc_app_version": cscAppVersion,
    "csc_project_board_url": cscProjectBoardUrl,
    "cs_dashboard_url": csDashboardUrl,
    "profile_edit_url": profileEditUrl,
    "user_groups": List<dynamic>.from(userGroups.map((x) => x)),
  };
}
