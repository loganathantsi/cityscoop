import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:CityScoop/app/components/utilities.dart';
import 'package:CityScoop/constants/strings.dart';
import 'package:CityScoop/middleware/networkinterceptor.dart';
import 'package:CityScoop/model/general_response_model.dart';
import 'package:CityScoop/model/login_response_model.dart';
import 'package:CityScoop/model/notification_token_model.dart';
import 'package:CityScoop/model/post_publish_notifications_response_model.dart';
import 'package:CityScoop/model/register_app_signup_response_model.dart';
import 'package:CityScoop/model/update_notifications_response_model.dart';
import 'package:CityScoop/model/upload_brand_model.dart';
import 'package:CityScoop/model/upload_video_response_model.dart';
import 'package:CityScoop/model/user_logo_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:path/path.dart';

class CityScoopRepository {

  static http.Client get client => InterceptedClient.build(interceptors: [NetworkInterceptor()]);

  static Future<http.Response> post(Uri url, {Map<String, String>? headers, Object? body}) => http.post(url, headers: headers, body: body);

  Uri getUri(String apiUrl) {
    if (apiUrl.isNotEmpty) {
      return Uri.parse(apiUrl);
    }
    return Uri.parse("");
  }

  Future<LoginResponse?> callLoginApi(String username, String password) async {
    final loginUrl = Strings.baseUrl + Strings.token;

    final http.Response response = await client.post(
        getUri(loginUrl),
        headers: Utilities.getHeadersWithoutToken(),
        body: jsonEncode({
          'username': username,
          'password': password,
        }));

    if (response.statusCode == 200) {
      LoginResponse loginResponse = LoginResponse.fromJson(json.decode(response.body));
      print("---> Login Response : ${loginResponse.userNicename}, ${loginResponse.userEmail}");
      return loginResponse;
    } else {
      print("---> Status Code : ${response.statusCode}");
      GeneralResponse errorResponse = GeneralResponse.fromJson(json.decode(response.body));
      print("---> Error Message : ${errorResponse.message}");
    }
    return null;
  }

  Future<RegisterAppSignUp?> registerAppSignupApi() async {
    final loginUrl = Strings.baseURL + Strings.registerAppSignup;

    final http.Response response = await client.post(
        getUri(loginUrl),
        headers: Utilities.getHeadersWithoutToken(),
        body: jsonEncode({
          "token": "webview"
        })
    );

    if (response.statusCode == 200) {
      RegisterAppSignUp registerAppSignUp = RegisterAppSignUp.fromJson(json.decode(response.body));
      print("---> RegisterAppSignUp Response : ${registerAppSignUp.success}, ${registerAppSignUp.regToken}");
      return registerAppSignUp;
    } else {
      print("---us Code : ${response.statusCode}");
      GeneralResponse errorResponse = GeneralResponse.fromJson(json.decode(response.body));
      print("---> Error Message : ${errorResponse.message}");
    }
    return null;
  }

  Future<PostPublishNotifications?> postPublishNotificationsApi() async {
    final loginUrl = Strings.baseURL + Strings.postPublishNotifications;

    final http.Response response = await client.post(
      getUri(loginUrl),
      headers: Utilities.getHeadersWithoutToken(),
    );

    if (response.statusCode == 200) {
      PostPublishNotifications postPublishNotifications = PostPublishNotifications.fromJson(json.decode(response.body));
      print("---> PostPublishNotifications Response : success: ${postPublishNotifications.success}, totalCount: ${postPublishNotifications.totalCount}");
      return postPublishNotifications;
    } else {
      print("---> Status Code : ${response.statusCode}");
      GeneralResponse errorResponse = GeneralResponse.fromJson(json.decode(response.body));
      print("---> Error Message : ${errorResponse.message}");
    }
    return null;
  }

  Future<UpdateNotification?> updateNotificationsApi({required String updateId, required String type, required int read, required int delete}) async {
    final loginUrl = Strings.baseURL + Strings.updateNotification;
    int id = int.parse(updateId);

    final http.Response response = await client.post(
      getUri(loginUrl),
      headers: Utilities.getHeadersWithoutToken(),
      body: jsonEncode({
      if(read == 1)
        "read": 1,
      if(delete == 1)
        "delete": 1,
        "id":[id],
        "type":[type]
      })
    );

    if (response.statusCode == 200) {
      UpdateNotification updateNotification = UpdateNotification.fromJson(json.decode(response.body));
      print("---> UpdateNotifications Response : success: ${updateNotification.success}, error: ${updateNotification.error}");
      return updateNotification;
    } else {
      print("---> Status Code : ${response.statusCode}");
      GeneralResponse errorResponse = GeneralResponse.fromJson(json.decode(response.body));
      print("---> Error Message : ${errorResponse.message}");
    }
    return null;
  }

  Future<UploadVideoReponse?> uploadVideo(File videoFile, String token) async {
    final uploadVideoUrl = Strings.baseURL + Strings.uploadVideo;
    var request = http.MultipartRequest('POST', getUri(uploadVideoUrl));

    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'Content-Type': 'multipart/form-data',
    });
    request.files.add(
      await http.MultipartFile.fromPath(
        'video',
        videoFile.path,
        filename: basename(videoFile.path),
      ),
    );

    var response = await request.send();
    var responseString = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      UploadVideoReponse uploadVideoReponse = UploadVideoReponse.fromJson(json.decode(responseString));
      print("---> Upload Success");
      print("---> UploadVideoReponse: ${uploadVideoReponse.success}, ${uploadVideoReponse.videoUrl}");
      return uploadVideoReponse;
    } else {
      print("---> Upload Failed Status Code : ${response.statusCode}");
    }
    return null;
  }

  Future<UserLogoResponse?> userLogoApi() async {
    final userLogoUrl = Strings.baseURL + Strings.userLogo;

    final http.Response response = await client.get(
      getUri(userLogoUrl),
      headers: Utilities.getHeadersWithoutToken(),
    );

    if (response.statusCode == 200) {
      UserLogoResponse userLogoResponse = UserLogoResponse.fromJson(json.decode(response.body));
      print("---> UserLogoResponse : ${userLogoResponse.status}, ${userLogoResponse.userlogoUrl}");
      return userLogoResponse;
    } else {
      print("---> Status Code : ${response.statusCode}");
      GeneralResponse errorResponse = GeneralResponse.fromJson(json.decode(response.body));
      print("---> Error Message : ${errorResponse.message}");
    }
    return null;
  }

  Future<ui.Image> loadImageFromUrl(String imageUrl) async {
    try {
      final http.Response response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        Uint8List bytes = response.bodyBytes;
        final Completer<ui.Image> completer = Completer();

        ui.decodeImageFromList(bytes, (ui.Image img) {
          completer.complete(img);
        });

        return completer.future;
      } else {
        throw Exception('Failed to load image: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error loading image: $e');
    }
  }

  Future<UploadBrandResponse> uploadBrandApi(String? fileExtension, String? base64String) async {
    final uploadBrandUrl = Strings.baseURL + Strings.uploadBrand;

    final http.Response response = await client.post(
        getUri(uploadBrandUrl),
        headers: Utilities.getHeadersWithoutToken(),
        body: jsonEncode({
          "ext": fileExtension ?? "",
          "image": "data:image/$fileExtension;base64,$base64String",
        })
    );

    if (response.statusCode == 200) {
      UploadBrandResponse uploadBrandResponse = UploadBrandResponse.fromJson(json.decode(response.body));
      print("---> Upload Success");
      print("---> UploadBrandResponse: ${uploadBrandResponse.status}, ${uploadBrandResponse.avatarUrl}");
      return uploadBrandResponse;
    } else {
      print("---> Upload Failed Status Code : ${response.statusCode}");
      throw Exception('Failed to upload image');
    }
  }

  Future<NotificationTokenResponse?> notificationTokenApi(String? token, String? deviceToken) async {
    final uploadVideoUrl = Strings.baseURL + Strings.notificationToken;

    var request = http.MultipartRequest('POST', getUri(uploadVideoUrl));

    request.headers.addAll({
      'Authorization': 'Bearer $token',
      'Content-Type': 'multipart/form-data',
    });

    request.fields["notification_token"] = deviceToken ?? "";

    var response = await request.send();
    var responseString = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      NotificationTokenResponse notificationTokenResponse = NotificationTokenResponse.fromJson(json.decode(responseString));
      print("---> notificationTokenResponse: ${notificationTokenResponse.success}, ${notificationTokenResponse.notificationToken}");
      return notificationTokenResponse;
    } else {
      print("---> notificationTokenResponse Status Code : ${response.statusCode}");
    }
    return null;
  }

}