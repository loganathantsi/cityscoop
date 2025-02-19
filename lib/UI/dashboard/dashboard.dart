import 'package:CityScoop/app/components/utilities.dart';
import 'package:CityScoop/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
            // crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    InkWell(
                      onTap: () {},
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
                    InkWell(
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
                  InkWell(
                    onTap: () {},
                    child: Container(
                        padding: EdgeInsets.all(10),
                        width: Utilities.getDeviceWidth(context) / 2,
                        height: 150,
                        child: Image.asset(Strings.dashProfileLogo, alignment: Alignment.center)),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                        padding: EdgeInsets.all(10),
                        width: Utilities.getDeviceWidth(context) / 2,
                        height: 150,
                        child: Image.asset(Strings.dashCalenderLogo, alignment: Alignment.center)),
                  ),
                ],),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                        padding: EdgeInsets.all(10),
                        width: Utilities.getDeviceWidth(context) / 2,
                        height: 150,
                        child: SvgPicture.asset(Strings.dashUploadVideoLogo,

                        )),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                        padding: EdgeInsets.all(10),
                        width: Utilities.getDeviceWidth(context) / 2,
                        height: 150,
                        child: SvgPicture.asset(Strings.dashUploadPhotoLogo,

                        )),
                  ),
                ],),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            "Home",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
