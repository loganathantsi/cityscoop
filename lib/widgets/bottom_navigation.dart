import 'package:CityScoop/UI/dashboard.dart';
import 'package:CityScoop/constants/strings.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(5, 3, 5, 0),
        color: Colors.white,
        height: 50,
        child: PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (!didPop) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardScreen()));
            }
          },
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
          ),
        ));
  }

}