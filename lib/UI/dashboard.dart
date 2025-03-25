import 'package:CityScoop/UI/upload_picture.dart';
import 'package:CityScoop/UI/upload_video.dart';
import 'package:CityScoop/app/components/utilities.dart';
import 'package:CityScoop/constants/strings.dart';
import 'package:CityScoop/UI/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardScreen extends StatefulWidget {

  const DashboardScreen({super.key});

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {

  String? accessToken, userName;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Utilities.getStringPreference(Strings.accessToken)
          .then((value) => setState(() {
        accessToken = value;
        Utilities.getStringPreference(Strings.dashboardUsername)
            .then((value) => setState(() {
          userName = value;
        }));
      }));
    });
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
              GestureDetector(
                onTap: () {
                  setState(() {
                    openUrlInBrowser("https://cityscoop.us/update-billing/");
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Text("UPDATE BILLING ", style: TextStyle(color: Colors.red.shade800, fontSize: 14, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Text("Welcome, $userName.", style: TextStyle(color: Colors.white, fontSize: 22), textAlign: TextAlign.center),
              ),
              GestureDetector(
                onTap: (){
                  setState(() {
                    openUrlInBrowser("https://cityscoop.us/oaklandca-electrical/wp-admin/admin.php?page=cs-dashboard&applogin=1&date=2024-04");
                  });
                },
                child: Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    width: Utilities.getDeviceWidth(context),
                    height: Utilities.getDeviceHeight(context) * 0.20,
                    child: Image.asset(Strings.dashLogo, alignment: Alignment.center)),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        openUrlInBrowser("https://cityscoop.us/all/members/cstestdh/profile/biz-profile-settings");
                      });
                    },
                    child: Container(
                        padding: EdgeInsets.all(10),
                        width: Utilities.getDeviceWidth(context) / 2,
                        height: Utilities.getDeviceHeight(context) * 0.15,
                        child: Image.asset(Strings.dashProfileLogo, alignment: Alignment.center)),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        openUrlInBrowser("https://app.asana.com/0/1206112293952328/1206112293952328");
                      });
                    },
                    child: Container(
                        padding: EdgeInsets.all(10),
                        width: Utilities.getDeviceWidth(context) / 2,
                        height: Utilities.getDeviceHeight(context) * 0.15,
                        child: Image.asset(Strings.dashCalenderLogo, alignment: Alignment.center)),
                  ),
                ],),
              Padding(
                padding: EdgeInsets.all(15),
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => UploadVideo()));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    width: Utilities.getDeviceWidth(context) / 8,
                                    height: Utilities.getDeviceHeight(context) * 0.09,
                                    child: Image.asset(Strings.dashUploadVideoLogo)),
                                SizedBox(width: 90, height: 30, child: Text("VIDEO", textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold))),
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
                                    width: Utilities.getDeviceWidth(context) / 8,
                                    height: Utilities.getDeviceHeight(context) * 0.09,
                                    child: Image.asset(Strings.dashUploadPhotoLogo, alignment: Alignment.center)),
                                SizedBox(width: 90, height: 30, child: Text("PHOTO", textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold))),
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

  void openUrlInBrowser(String url) {
    final Uri uri = Uri.parse(url);
    launchUrl(uri, mode: LaunchMode.externalApplication);
  }

}
