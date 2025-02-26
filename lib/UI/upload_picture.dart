import 'package:CityScoop/UI/dashboard.dart';
import 'package:CityScoop/app/components/utilities.dart';
import 'package:CityScoop/constants/strings.dart';
import 'package:flutter/material.dart';

class UploadPicture extends StatefulWidget {
  const UploadPicture({super.key});

  @override
  UploadPictureState createState() => UploadPictureState();
}

class UploadPictureState extends State<UploadPicture> {

  bool isSwitch = false;

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
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 100),
                  SizedBox(
                      width: Utilities.getDeviceWidth(context) / 3,
                      height: 125,
                      child: Image.asset(Strings.dashUploadPhotoLogo, alignment: Alignment.center, fit: BoxFit.fill)),
                  SizedBox(height: 40, child: Text("UPLOAD PICTURE", textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 16))),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(child: Text("Show logo")),
                        Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Transform.scale(
                                    scaleX: 1.1,
                                    scaleY: 1,
                                    child: Switch(
                                      value: isSwitch,
                                      onChanged: (value) {
                                        setState(() {
                                          isSwitch = value;
                                        });
                                      },
                                      trackOutlineColor: WidgetStateProperty.resolveWith<Color?>(
                                            (Set<WidgetState> states) {
                                          if (states.contains(WidgetState.selected)) {
                                            return Colors.grey.shade300; // Outline color when switch is ON
                                          }
                                          return Colors.grey.shade300; // Outline color when switch is OFF
                                        },
                                      ),
                                      activeColor: Colors.red,
                                      activeTrackColor: Colors.white,
                                      inactiveThumbColor: Colors.grey.shade400,
                                      inactiveTrackColor: Colors.white,
                                    ),
                                  ),
                                  Positioned(
                                    left: isSwitch ? 10 : 30, // Adjust position based on switch state
                                    child: Text(
                                      isSwitch ? "ON" : "OFF",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: isSwitch ? Colors.red : Colors.grey,
                                      ),
                                    ),
                                  ),
                                ]
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: Utilities.getDeviceWidth(context),
                    height: 75,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[800],
                          padding: const EdgeInsets.symmetric(vertical: 5),
                        ).copyWith(
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        onPressed: () {},
                        child: Text('SUBMIT',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
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
