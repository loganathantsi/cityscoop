import 'package:CityScoop/app/components/utilities.dart';
import 'package:CityScoop/constants/strings.dart';
import 'package:CityScoop/widgets/bottom_navigation.dart';
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
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
