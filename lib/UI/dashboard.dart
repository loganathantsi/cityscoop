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
  final ScrollController _scrollController = ScrollController();

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
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                child: Text("Welcome, $userName.", style: TextStyle(color: Colors.white, fontSize: 22, fontFamily: "LevenimMT",  fontWeight: FontWeight.bold), textAlign: TextAlign.center),
              ),
              GestureDetector(
                onTap: (){
                  setState(() {
                    openUrlInBrowser("https://cityscoop.us/oaklandca-electrical/wp-admin/admin.php?page=cs-dashboard&applogin=1&date=2024-04");
                  });
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          width: Utilities.getDeviceWidth(context),
                          height: Utilities.getDeviceHeight(context) * 0.20,
                          child: Image.asset(Strings.dashLogo, alignment: Alignment.center)),
                        Positioned(
                          bottom: 0,
                          child: SizedBox(
                              height: 40,
                              child: Text("DASHBOARD",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "LevenimMT",
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold))),
                        ),
                      ]
                    ),
                    SizedBox(
                        child: Text("Metrics & Analysis",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                letterSpacing: 1.8,
                                color: Colors.white,
                                fontFamily: "LevenimMT",
                                fontSize: 18))),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        openUrlInBrowser("https://cityscoop.us/all/members/cstestdh/profile/biz-profile-settings");
                      });
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            padding: EdgeInsets.all(10),
                            width: Utilities.getDeviceWidth(context) / 2,
                            height: Utilities.getDeviceHeight(context) * 0.12,
                            child: Image.asset(Strings.profileLogo, alignment: Alignment.center, scale: 2)),
                        SizedBox(height: 25, child: Text("PROFILE", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontFamily: "LevenimMT", fontSize: 18, fontWeight: FontWeight.bold))),
                        SizedBox(height: 25, child: Text("Company Info", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontFamily: "LevenimMT", fontSize: 12, fontWeight: FontWeight.bold))),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        openUrlInBrowser("https://app.asana.com/0/1206112293952328/1206112293952328");
                      });
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: Utilities.getDeviceHeight(context) * 0.01),
                        Container(
                            padding: EdgeInsets.all(10),
                            width: Utilities.getDeviceWidth(context) / 2,
                            height: Utilities.getDeviceHeight(context) * 0.10,
                            child: Image.asset(Strings.calenderLogo, alignment: Alignment.center)),
                        SizedBox(height: Utilities.getDeviceHeight(context) * 0.01),
                        SizedBox(height: 25, child: Text("CALENDAR", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontFamily: "LevenimMT", fontSize: 18, fontWeight: FontWeight.bold))),
                        SizedBox(height: 25, child: Text("Campaign Details", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontFamily: "LevenimMT", fontSize: 12, fontWeight: FontWeight.bold))),
                      ],
                    ),
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
