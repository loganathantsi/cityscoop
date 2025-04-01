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
        color: Colors.white,
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                dialogNotifications(context);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  badges.Badge(
                    position: badges.BadgePosition.topEnd(top: -7, end: -21),
                    badgeAnimation: badges.BadgeAnimation.slide(),
                    showBadge: controller.showNotificationBadge.value,
                    badgeStyle: badges.BadgeStyle(
                      shape: badges.BadgeShape.square,
                      borderRadius: BorderRadius.circular(8),
                      badgeColor: color, // Customize badge color
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    ),
                    badgeContent: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2),
                      child: Text(
                        controller.notificationBadgeAmount.value.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                    child: SizedBox(
                      height: 25,
                      child: Image.asset(
                        Strings.notificationIcon,
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                  Text("NOTICES",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(Strings.homeIcon,
                      alignment: Alignment.center, height: 25),
                  Text("HOME",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                dialogLogout(context);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 25,
                      child: Image.asset(Strings.logoutIcon,
                          alignment: Alignment.center)),
                  Text("LOG OUT",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
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
