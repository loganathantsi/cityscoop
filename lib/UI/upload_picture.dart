import 'package:CityScoop/app/components/utilities.dart';
import 'package:CityScoop/constants/strings.dart';
import 'package:CityScoop/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:image_picker/image_picker.dart';

class UploadPicture extends StatefulWidget {
  const UploadPicture({super.key});

  @override
  UploadPictureState createState() => UploadPictureState();
}

class UploadPictureState extends State<UploadPicture> {

  bool isSwitch = false;
  String selectedValue = "Select";
  final dropDownKey = GlobalKey<DropdownSearchState>();

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
                  SizedBox(height: 50),
                  GestureDetector(
                    onTap: () {
                      showImagePickerBottomSheet(context);
                    },
                    child: SizedBox(
                        width: Utilities.getDeviceWidth(context) / 3,
                        height: 125,
                        child: Image.asset(Strings.dashUploadPhotoLogo, alignment: Alignment.center, fit: BoxFit.fill)),
                  ),
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
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isSwitch = !isSwitch;
                                        });
                                      },
                                      child: Text(
                                        isSwitch ? "ON" : "OFF",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: isSwitch ? Colors.red : Colors.grey,
                                        ),
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
                  isSwitch ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 6, 0, 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(child: Text("Logo")),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 6, 0, 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(child: Text("Select Position")),
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                          child: DropdownSearch<String>(
                            key: dropDownKey,
                            selectedItem: selectedValue,
                            items: (filter, infiniteScrollProps) => ["Select", "Bottom right", "Bottom left", "Top right", "Top left"],
                            popupProps: PopupProps.menu(
                              fit: FlexFit.loose,
                              constraints: BoxConstraints(),
                            ),
                          )

                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 25, 0, 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(child: Text("Select Transparency")),
                          ],
                        ),
                      ),
                    ],
                  ) : SizedBox(),
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
      bottomNavigationBar: BottomNavigation(),
    );
  }

  void showImagePickerBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    height: 40,
                    child: Center(
                      child: Text("UPLOAD PICTURE",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey),
                      ),
                    )
                ),
                Divider(color: Colors.grey.shade200),
                GestureDetector(
                  onTap: () => pickImage(context, ImageSource.camera),
                  child: SizedBox(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt, color: Colors.grey),
                          Text(" Camera",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      )),
                ),
                Divider(color: Colors.grey.shade200),
                GestureDetector(
                  onTap: () => pickImage(context, ImageSource.gallery),
                  child: SizedBox(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.photo_library, color: Colors.grey),
                          Text(" Gallery",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void pickImage(BuildContext context, ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      print('Selected Image Path: ${image.path}');
    }
    Navigator.pop(context); // Close bottom sheet
  }

}
