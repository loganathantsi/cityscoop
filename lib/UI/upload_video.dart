import 'package:CityScoop/UI/dashboard.dart';
import 'package:CityScoop/app/components/utilities.dart';
import 'package:CityScoop/constants/strings.dart';
import 'package:flutter/material.dart';

class UploadVideo extends StatefulWidget {
  const UploadVideo({super.key});

  @override
  UploadVideoState createState() => UploadVideoState();
}

class UploadVideoState extends State<UploadVideo> {

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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: Utilities.getDeviceWidth(context) / 3,
                        height: 125,
                        child: Image.asset(Strings.dashUploadVideoLogo, alignment: Alignment.center, fit: BoxFit.fill)),
                    SizedBox(height: 40, child: Text("UPLOAD VIDEO", textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 18))),
                  ],
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
              GestureDetector(onTap:() {
                Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardScreen()));
              }, child: Image.asset(Strings.homeIcon, alignment: Alignment.center, height: 25)),
              GestureDetector(onTap:() {
                Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardScreen()));
              }, child: Text("HOME", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold))),
              Expanded(child: SizedBox()),
              SizedBox(width: 120, child: Divider(color: Colors.red, height: 2)),
            ],
          )),
    );
  }
}
