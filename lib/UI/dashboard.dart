import 'package:CityScoop/UI/upload_picture.dart';
import 'package:CityScoop/UI/upload_video.dart';
import 'package:CityScoop/app/components/utilities.dart';
import 'package:CityScoop/constants/strings.dart';
import 'package:CityScoop/model/post_publish_notifications_response_model.dart';
import 'package:CityScoop/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  final PostPublishNotifications? postPublishNotifications;

  const DashboardScreen({super.key, this.postPublishNotifications});

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {

  String? accessToken, userName;

  @override
  void initState() {
    super.initState();
    Utilities.getStringPreference(Strings.accessToken)
        .then((value) => setState(() {
          accessToken = value;
          Utilities.getStringPreference(Strings.dashboardUsername)
              .then((value) => setState(() {
                userName = value;
              }));
        }));
  }

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
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Text("UPDATE BILLING, ", style: TextStyle(color: Colors.red.shade800, fontSize: 14, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25, bottom: 25),
                child: Text("Welcome, $userName", style: TextStyle(color: Colors.white, fontSize: 22), textAlign: TextAlign.center),
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  width: Utilities.getDeviceWidth(context),
                  height: 180,
                  child: Image.asset(Strings.dashLogo, alignment: Alignment.center)),
              SizedBox(height: 25),
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
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => UploadVideo()));
                            },
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
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
