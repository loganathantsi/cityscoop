import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:CityScoop/api/repository.dart';
import 'package:CityScoop/app/components/utilities.dart';
import 'package:CityScoop/constants/strings.dart';
import 'package:CityScoop/UI/bottom_navigation.dart';
import 'package:CityScoop/count_controller.dart';
import 'package:CityScoop/main.dart';
import 'package:CityScoop/model/upload_brand_model.dart';
import 'package:CityScoop/model/user_logo_response_model.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import '../model/post_publish_notifications_response_model.dart';
import 'dashboard.dart';

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
  ui.Image? finalWatermarkedImage;
  ui.Image? watermarkImage;
  double _opacity = 0.5;
  String? fileExtensionSelectedImage, base64StringSelectedImage;
  String? fileExtensionFinalImage, base64StringFinalImage;

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
                                                if(value == false){
                                                  selectedValue = "Select";
                                                  _opacity = 0.5;
                                                  finalWatermarkedImage = null;
                                                }
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
                                child: RawImage(image: watermarkImage, fit: BoxFit.fill),
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
                                onChanged: (value) {
                                  setState(() {
                                    selectedValue = value ?? "Select";
                                    navigateToPreview();
                                  });
                                },
                              )

                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12, 25, 0, 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(child: Text("Select Transparency")),
                                Slider(
                                  value: _opacity,
                                  min: 0.0,
                                  max: 1.0,
                                  divisions: 4,
                                  onChanged: (value) {
                                    setState(() {
                                      _opacity = value;
                                      navigateToPreview();
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ) : SizedBox(),
                      if(_selectedImage != null && finalWatermarkedImage == null)
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Image.file(_selectedImage!),
                        ),
                      if(finalWatermarkedImage != null)
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: RawImage(image: finalWatermarkedImage),
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
                            onPressed: () {
                              if (_selectedImage != null && finalWatermarkedImage == null) {
                                uploadBrandApi(fileExtensionSelectedImage, base64StringSelectedImage);
                              } else if (finalWatermarkedImage != null && isSwitch == true) {
                                uploadBrandApi(fileExtensionFinalImage, base64StringFinalImage);
                              }
                            },
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
                    height: 50,
                    child: Center(
                      child: Text("UPLOAD PICTURE",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black),
                      ),
                    )
                ),
                Divider(color: Colors.grey.shade200),
                GestureDetector(
                  onTap: () => pickImage(context, ImageSource.camera),
                  child: SizedBox(
                      height: 45,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                      height: 45,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                Divider(color: Colors.grey.shade200),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: SizedBox(
                      height: 40,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text("Cancel",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.red.shade800),
                          ),
                        ),
                      )
                  ),
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
      print('---> Selected Image Path: ${image.path}');
        _selectedImage = File(image.path);
      List<int> imageBytes = await File(image.path).readAsBytes();
      setState(() {
        base64StringSelectedImage = base64Encode(imageBytes);
        fileExtensionSelectedImage = path.extension(File(image.path).path).replaceFirst(".", "");

        print("---> base64StringSelectedImage: $base64StringSelectedImage");
        print("---> fileExtensionSelectedImage: $fileExtensionSelectedImage");
      });
    }
    Navigator.pop(context); // Close bottom sheet
  }

  Future<void> navigateToPreview() async {
    if (_selectedImage == null) return;

    final ui.Image originalImage = await _loadUiImage(_selectedImage!);
    await _applyWatermark(originalImage).then((value) {
      setState(() async {
      finalWatermarkedImage = value;
      base64StringFinalImage = await convertUiImageToBase64(value);
      fileExtensionFinalImage = "png";
      print("---> base64StringFinalImage: $base64StringFinalImage");
      print("---> fileExtensionFinalImage: $fileExtensionFinalImage");
      });
    });

  }

  Future<String> convertUiImageToBase64(ui.Image image) async {
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData == null) return "";
    Uint8List imageBytes = byteData.buffer.asUint8List();
    String base64String = base64Encode(imageBytes);
    return base64String;
  }

  Future<ui.Image> _loadUiImage(File file) async {
    final Uint8List bytes = await file.readAsBytes();
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(bytes, (ui.Image img) {
      completer.complete(img);
    });
    return completer.future;
  }

  Future<ui.Image> _applyWatermark(ui.Image image) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final paint = Paint()..filterQuality = FilterQuality.high;
    final imageSize = Size(image.width.toDouble(), image.height.toDouble());

    canvas.drawImage(image, Offset.zero, paint);

    if (watermarkImage != null) {
      final paintWatermark = Paint()
        ..color = Color.fromARGB((_opacity * 255).toInt(), 255, 255, 255) // Dynamic opacity
        ..blendMode = BlendMode.srcOver;

      double watermarkWidth = imageSize.width * 0.3;
      double watermarkHeight = (watermarkImage!.height / watermarkImage!.width) * watermarkWidth;

      double dx = 20;
      double dy = 20;

      switch (selectedValue) {
        case "Bottom right":
          setState(() {
            dx = imageSize.width - watermarkWidth - 20;
            dy = imageSize.height - watermarkHeight - 20;
          });
          break;
        case "Bottom left":
          setState(() {
            dx = 20;
            dy = imageSize.height - watermarkHeight - 20;
          });
          break;
        case "Top right":
          setState(() {
            dx = imageSize.width - watermarkWidth - 20;
            dy = 20;
          });
          break;
        case "Top left":
          setState(() {
            dx = 20;
            dy = 20;
          });
          break;
        default:
          setState(() {
            dx = imageSize.width - watermarkWidth - 20;
            dy = imageSize.height - watermarkHeight - 20;
            watermarkWidth = 0;
            watermarkHeight = 0;
          });
      }

      final Rect watermarkRect = Rect.fromLTWH(dx, dy, watermarkWidth, watermarkHeight);
      canvas.drawImageRect(
          watermarkImage!,
          Rect.fromLTWH(0, 0, watermarkImage!.width.toDouble(),
              watermarkImage!.height.toDouble()),
          watermarkRect,
          paintWatermark);
    }

    final picture = recorder.endRecording();
    return picture.toImage(image.width, image.height);
  }

  Future<void> userLogoApi() async {
    EasyLoading.show(status: 'loading...');
    await CityScoopRepository().userLogoApi().then((value) {
      setState(() {
        if(value != null) {
          userLogoResponse = value;
          userLogoUrl = userLogoResponse?.userlogoUrl;
          CityScoopRepository().loadImageFromUrl(userLogoUrl!).then((value) {
            setState(() {
              watermarkImage = value;
            });
          }).whenComplete((){
            setState(() {
              EasyLoading.dismiss();
              showImagePickerBottomSheet(context);
            });
          });
        }
      });
    }
    );
  }

  Future<void> uploadBrandApi(String? fileExtension, String? base64String) async {
    EasyLoading.show(status: 'loading...');
    UploadBrandResponse? uploadBrandResponse = await CityScoopRepository().uploadBrandApi(fileExtension, base64String);
    if(uploadBrandResponse != null) {
      setState(() {
        postPublishNotificationsApi(context);
      });
    } else {
      EasyLoading.dismiss();
      error();
    }
  }

  Future<void> postPublishNotificationsApi(BuildContext context) async {
    final PostPublishNotifications? postPublishNotifications = await CityScoopRepository().postPublishNotificationsApi();
    final CounterController controller = Get.find<CounterController>();
    if (postPublishNotifications != null) {
      setState(() {
        EasyLoading.dismiss();
        success();
        controller.notificationBadgeAmount.value = postPublishNotifications.unreadCount ?? 0;
        controller.showNotificationBadge.value = postPublishNotifications.unreadCount != 0;
        navigatorKey.currentState?.pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => DashboardScreen(),
              settings: RouteSettings(name: "DashboardScreen")),
              (Route<dynamic> route) => false,
        );
      });
    } else {
      EasyLoading.dismiss();
    }
  }

  void success() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Image uploaded successfully')),
    );
  }

  void error() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Image upload failed')),
    );
  }

}
