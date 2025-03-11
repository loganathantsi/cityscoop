import 'dart:io';
import 'package:CityScoop/api/repository.dart';
import 'package:CityScoop/app/components/utilities.dart';
import 'package:CityScoop/constants/strings.dart';
import 'package:CityScoop/UI/bottom_navigation.dart';
import 'package:CityScoop/model/user_logo_response_model.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
  UserLogoResponse? userLogoResponse;
  String? accessToken, userLogoUrl;
  File? _selectedImage;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Utilities.getStringPreference(Strings.accessToken).then((value) {
      setState(() {
        accessToken = value;
      });
    }).whenComplete((){
      userLogoApi();
    });
  }

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
              SizedBox(height: 5),
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
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
                                              if(_selectedImage != null) {
                                                isSwitch = value;
                                              } else {
                                                errorSwitch();
                                              }
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
                                          activeColor: Colors.red.shade800,
                                          activeTrackColor: Colors.white,
                                          inactiveThumbColor: Colors.grey.shade400,
                                          inactiveTrackColor: Colors.white,
                                        ),
                                      ),
                                      Positioned(
                                        left: isSwitch ? 10 : 30,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if(_selectedImage != null) {
                                                isSwitch = !isSwitch;
                                              } else {
                                                errorSwitch();
                                              }
                                            });
                                          },
                                          child: Text(
                                            isSwitch ? "ON" : "OFF",
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: isSwitch ? Colors.red.shade800 : Colors.grey,
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
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(12, 6, 6, 6),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(child: Text("Logo")),
                                  ],
                                ),
                              ),
                              SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Image.network("$userLogoUrl", alignment: Alignment.center, fit: BoxFit.fill)
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12, 12, 0, 6),
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
                      if(_selectedImage != null)
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Image.file(_selectedImage!),
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
                      SizedBox(height: 15)
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }

  void errorSwitch() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Capture new image to change brand logo')),
    );
  }

  Future<void> userLogoApi() async {
    EasyLoading.show(status: 'loading...');
    await CityScoopRepository().userLogoApi().then((value) {
      setState(() {
        if(value != null) {
          userLogoResponse = value;
          userLogoUrl = userLogoResponse?.userlogoUrl;
          EasyLoading.dismiss();
        }
      });
    }
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
      setState(() {
        _selectedImage = File(image.path);
      });
    }
    Navigator.pop(context); // Close bottom sheet
  }

}
