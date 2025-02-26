import 'package:CityScoop/UI/dialog_notifications.dart';
import 'package:CityScoop/UI/upload_picture.dart';
import 'package:CityScoop/app/components/utilities.dart';
import 'package:CityScoop/constants/strings.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(15),
                  width: Utilities.getDeviceWidth(context),
                  height: 100,
                  child: Image.asset(Strings.logoGrey, fit: BoxFit.scaleDown)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          dialogNotifications();
                        });
                      },
                      child: Container(
                          padding: EdgeInsets.all(10),
                          width: Utilities.getDeviceWidth(context) * 0.25,
                          height: 50,
                          child: Image.asset(Strings.notificationIcon, alignment: Alignment.center)),
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                        width: Utilities.getDeviceWidth(context) * 0.25,
                        height: 50,
                        child: Text("NOTICES", style: TextStyle(color: Colors.grey), textAlign: TextAlign.center)),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                          padding: EdgeInsets.all(10),
                          width: Utilities.getDeviceWidth(context) * 0.15,
                          height: 50,
                          child: Image.asset(Strings.logoutIcon, alignment: Alignment.center)),
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                        width: Utilities.getDeviceWidth(context) * 0.25,
                        height: 50,
                        child: Text("LOG OUT", style: TextStyle(color: Colors.grey), textAlign: TextAlign.center)),
                  ],
                ),
              ],),
              Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  width: Utilities.getDeviceWidth(context),
                  height: 180,
                  child: Image.asset(Strings.dashLogo, alignment: Alignment.center)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                        padding: EdgeInsets.all(10),
                        width: Utilities.getDeviceWidth(context) / 2,
                        height: 125,
                        child: Image.asset(Strings.dashProfileLogo, alignment: Alignment.center)),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                        padding: EdgeInsets.all(10),
                        width: Utilities.getDeviceWidth(context) / 2,
                        height: 125,
                        child: Image.asset(Strings.dashCalenderLogo, alignment: Alignment.center)),
                  ),
                ],),
              Expanded(child: SizedBox()),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white, // Background color
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                  padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("UPLOAD", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    width: Utilities.getDeviceWidth(context) / 6,
                                    height: 60,
                                    child: Image.asset(Strings.dashUploadVideoLogo)),
                                SizedBox(width: 90, height: 40, child: Text("UPLOAD VIDEO", textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold))),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap:() {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => UploadPicture()));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    width: Utilities.getDeviceWidth(context) / 6,
                                    height: 60,
                                    child: Image.asset(Strings.dashUploadPhotoLogo, alignment: Alignment.center)),
                                SizedBox(width: 90, height: 40, child: Text("UPLOAD PHOTO", textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold))),
                              ],
                            ),
                          ),
                        ],),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
          padding: EdgeInsets.fromLTRB(5, 3, 5, 0),
          color: Colors.white,
          height: 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(onTap:() {}, child: Image.asset(Strings.homeIcon, alignment: Alignment.center, height: 25)),
              GestureDetector(onTap:() {}, child: Text("HOME", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold))),
              Expanded(child: SizedBox()),
              SizedBox(width: 120, child: Divider(color: Colors.red, height: 2)),
            ],
          )),
    );
  }

  void dialogNotifications() {
    showDialog(
      context: context,
      builder: (context) => DialogNotifications(),
    );
  }
}
