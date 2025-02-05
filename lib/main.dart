import 'package:flutter/material.dart';

import 'login.dart';

void main() {
  runApp(CityScoop());
}

class CityScoop extends StatelessWidget {
  const CityScoop({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}


