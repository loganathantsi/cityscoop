import 'package:CityScoop/UI/dashboard.dart';
import 'package:CityScoop/UI/dialog_logout.dart';
import 'package:CityScoop/UI/dialog_notifications.dart';
import 'package:CityScoop/constants/strings.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

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
                dialogNotifications(context);
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
                dialogLogout(context);
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

  void dialogNotifications(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => DialogNotifications(),
    );
  }

  void dialogLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => DialogLogout(),
    );
  }

}