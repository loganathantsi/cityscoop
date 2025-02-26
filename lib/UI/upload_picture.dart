import 'package:CityScoop/app/components/utilities.dart';
import 'package:CityScoop/constants/strings.dart';
import 'package:flutter/material.dart';

class UploadPicture extends StatefulWidget {
  const UploadPicture({super.key});

  @override
  UploadPictureState createState() => UploadPictureState();
}

class UploadPictureState extends State<UploadPicture> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InkWell(
                onTap: () {
                  showImagePickerSnackbar(context);
                },
                child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(15),
                    width: Utilities.getDeviceWidth(context),
                    height: 100,
                    child: Image.asset(Strings.logoGrey, fit: BoxFit.scaleDown)),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 100),
                  SizedBox(
                      width: Utilities.getDeviceWidth(context) / 3,
                      height: 125,
                      child: Image.asset(Strings.dashUploadPhotoLogo, alignment: Alignment.center, fit: BoxFit.fill)),
                  SizedBox(height: 40, child: Text("UPLOAD PICTURE", textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 16))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(child: Text("Show logo")),
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text("OFF"),
                            Switch(
                              value: true,
                              onChanged: (value) {
                                setState(() {
                                  // isSwitched = value;
                                });
                              },
                              activeColor: Colors.green, // Color when switch is ON
                              inactiveThumbColor: Colors.grey, // Color when switch is OFF
                            ),
                            const Text("ON"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 125,
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
              InkWell(onTap:() {}, child: Image.asset(Strings.homeIcon, alignment: Alignment.center, height: 25)),
              InkWell(onTap:() {}, child: Text("HOME", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold))),
              Expanded(child: SizedBox()),
              SizedBox(width: 120, child: Divider(color: Colors.red, height: 2)),
            ],
          )),
    );
  }

  void showImagePickerSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Choose an option"),
        duration: Duration(seconds: 5), // Adjust as needed
        action: SnackBarAction(
          label: "Camera",
          onPressed: () {
            // Open Camera
            print("Camera Selected");
            // Implement your camera logic here
          },
        ),
      ),
    );

    // Delay for second action so both options are visible
    Future.delayed(Duration(milliseconds: 100), () {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Choose an option"),
          duration: Duration(seconds: 5),
          action: SnackBarAction(
            label: "Gallery",
            onPressed: () {
              // Open Gallery
              print("Gallery Selected");
              // Implement your gallery logic here
            },
          ),
        ),
      );
    });
  }

}
