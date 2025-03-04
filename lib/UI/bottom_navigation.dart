import 'package:CityScoop/UI/dashboard.dart';
import 'package:CityScoop/count_controller.dart';
import 'package:badges/badges.dart' as badges;
import 'package:CityScoop/UI/dialog_logout.dart';
import 'package:CityScoop/UI/dialog_notifications.dart';
import 'package:CityScoop/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({super.key});

  Color color = Colors.red;
  final CounterController controller = Get.find<CounterController>();

  @override
  Widget build(BuildContext context) {

    return Obx(() => Container(
        padding: EdgeInsets.fromLTRB(5, 8, 5, 0),
        color: Colors.white,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                dialogNotifications(context);
              },
              child: Column(
                children: [
                  badges.Badge(
                    position: badges.BadgePosition.topEnd(top: -8, end: -12),
                    badgeAnimation: badges.BadgeAnimation.slide(),
                    showBadge: controller.showNotificationBadge.value,
                    badgeStyle: badges.BadgeStyle(
                      badgeColor: color,
                    ),
                    badgeContent: Text(
                      controller.notificationBadgeAmount.value.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    child: SizedBox(
                        height: 25,
                        child: Image.asset(Strings.notificationIcon,
                            alignment: Alignment.center)),
                  ),
                  Text("NOTICES",
                      style: TextStyle(color: Colors.grey),
                      textAlign: TextAlign.center),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                if (ModalRoute.of(context)?.settings.name !=
                    "DashboardScreen") {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DashboardScreen(),
                        settings: RouteSettings(name: "DashboardScreen")),
                    (Route<dynamic> route) => false,
                  );
                }
              },
              child: Column(
                children: [
                  Image.asset(Strings.homeIcon,
                      alignment: Alignment.center, height: 25),
                  Text("HOME",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  SizedBox(
                      width: 120,
                      child: Divider(color: Colors.red.shade800, height: 1)),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                dialogLogout(context);
              },
              child: Column(
                children: [
                  SizedBox(
                      height: 25,
                      child: Image.asset(Strings.logoutIcon,
                          alignment: Alignment.center)),
                  Text("LOG OUT",
                      style: TextStyle(color: Colors.grey),
                      textAlign: TextAlign.center),
                ],
              ),
            ),
          ],
        )));
  }

  void dialogNotifications(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => DialogNotifications(),
    );
  }

  void dialogLogout(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => DialogLogout(),
    );
  }

}
