import 'package:CityScoop/UI/dashboard.dart';
import 'package:CityScoop/UI/dialog_logout.dart';
import 'package:CityScoop/UI/dialog_notifications.dart';
import 'package:CityScoop/api/repository.dart';
import 'package:CityScoop/constants/strings.dart';
import 'package:CityScoop/model/post_publish_notifications_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  BottomNavigationState createState() => BottomNavigationState();
}

  class BottomNavigationState extends State<BottomNavigation> {

  PostPublishNotifications? postPublishNotification;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
        padding: EdgeInsets.fromLTRB(5, 8, 5, 0),
        color: Colors.white,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  postPublishNotificationsApi(context);
                });
              },
              child: Column(
                children: [
                  SizedBox(height: 25, child: Image.asset(Strings.notificationIcon, alignment: Alignment.center)),
                  Text("NOTICES", style: TextStyle(color: Colors.grey), textAlign: TextAlign.center),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                if (ModalRoute.of(context)?.settings.name != "DashboardScreen") {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                      builder: (context) => DashboardScreen(),
                      settings: RouteSettings(name: "DashboardScreen")
                  ),
                  (Route<dynamic> route) => false,
                  );
                }
              },
              child: Column(
                children: [
                  Image.asset(Strings.homeIcon, alignment: Alignment.center, height: 25),
                  Text("HOME", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  SizedBox(width: 120, child: Divider(color: Colors.red.shade800, height: 1)),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  dialogLogout(context);
                });
              },
              child: Column(
                children: [
                  SizedBox(height: 25, child: Image.asset(Strings.logoutIcon, alignment: Alignment.center)),
                  Text("LOG OUT", style: TextStyle(color: Colors.grey), textAlign: TextAlign.center),
                ],
              ),
            ),
          ],
        ));
  }

  void dialogLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => DialogLogout(),
    );
  }

  Future<void> postPublishNotificationsApi(BuildContext context) async {
    EasyLoading.show(status: 'loading...');
    postPublishNotification = await CityScoopRepository().postPublishNotificationsApi()
        .whenComplete(() {
        setState(() {
          showDialog(
            context: context,
            builder: (context) => DialogNotifications(postPublishNotifications: postPublishNotification),
          );
        });
        EasyLoading.dismiss();
    }
    );
  }
}