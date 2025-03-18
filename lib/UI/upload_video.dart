import 'dart:io';
import 'package:CityScoop/api/repository.dart';
import 'package:CityScoop/app/components/utilities.dart';
import 'package:CityScoop/constants/strings.dart';
import 'package:CityScoop/UI/bottom_navigation.dart';
import 'package:CityScoop/count_controller.dart';
import 'package:CityScoop/main.dart';
import 'package:CityScoop/model/post_publish_notifications_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'dashboard.dart';
import 'full_screen_video_preview.dart';

class UploadVideo extends StatefulWidget {
  const UploadVideo({super.key});

  @override
  UploadVideoState createState() => UploadVideoState();
}

class UploadVideoState extends State<UploadVideo> {

  File? _video;
  VideoPlayerController? _controller;
  final picker = ImagePicker();

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(15),
                  width: Utilities.getDeviceWidth(context),
                  height: 100,
                  child: Image.asset(Strings.logoGrey, fit: BoxFit.scaleDown)),
              Divider(height: 1, color: Colors.grey.shade200),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      pickVideo();
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: Utilities.getDeviceWidth(context) / 3,
                          height: 125,
                          child: Image.asset(Strings.dashUploadVideoLogo, alignment: Alignment.center, fit: BoxFit.fill)
                      ),
                      SizedBox(
                          height: 40,
                          child: Text("UPLOAD VIDEO", textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 18))
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }

  Future pickVideo() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {

      setState(() {
        _video = File(pickedFile.path);
        _controller = VideoPlayerController.file(_video!)
          ..initialize().then((_) {
            setState(() {});
            _controller!.play();
          });
      });

      Navigator.push(context,
        MaterialPageRoute(builder: (context) =>
            FullScreenVideoPreview(
              videoFile: _video!,
              controller: _controller!,
              onSubmit: () {
                EasyLoading.show(status: 'Please be patient. It may take up to 10 minutes to upload your video. Videos need to be 2-3 minutes in length so you may need to record your video again if it is too long. Thank you!' );
                Utilities.getStringPreference(Strings.accessToken).then((value) =>
                  CityScoopRepository().uploadVideo(_video!, value).whenComplete(() {
                    setState(() {
                      postPublishNotificationsApi(context);
                    });
                }));
              },
            ),
        ),
      );

    }
  }

  Future<void> postPublishNotificationsApi(BuildContext context) async {
    final PostPublishNotifications? postPublishNotifications = await CityScoopRepository().postPublishNotificationsApi();
    final CounterController controller = Get.find<CounterController>();
    if (postPublishNotifications != null) {
      setState(() {
        EasyLoading.dismiss();
        success();
        controller.notificationBadgeAmount.value = postPublishNotifications.unreadCount ?? 0;
        controller.showNotificationBadge.value = postPublishNotifications.unreadCount != 0;
        navigatorKey.currentState?.pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => DashboardScreen(),
              settings: RouteSettings(name: "DashboardScreen")),
              (Route<dynamic> route) => false,
        );
      });
    } else {
      EasyLoading.dismiss();
    }
  }

  void success() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Video uploaded successfully')),
    );
  }

}
