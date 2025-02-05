// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:firebase_storage/firebase_storage.dart';
// import 'dart:io';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   // await Firebase.initializeApp();
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: UploadScreen(),
//     );
//   }
// }
//
// class UploadScreen extends StatefulWidget {
//   @override
//   _UploadScreenState createState() => _UploadScreenState();
// }
//
// class _UploadScreenState extends State<UploadScreen> {
//   final ImagePicker _picker = ImagePicker();
//   File? _media;
//   bool _isUploading = false;
//
//   Future<void> _pickMedia(ImageSource source, {bool isVideo = false}) async {
//     final pickedFile = isVideo
//         ? await _picker.pickVideo(source: source)
//         : await _picker.pickImage(source: source);
//
//     if (pickedFile != null) {
//       setState(() {
//         _media = File(pickedFile.path);
//       });
//     }
//   }
//
//   Future<void> _uploadMedia() async {
//     if (_media == null) return;
//     setState(() => _isUploading = true);
//
//     try {
//       String fileName = _media!.path.split('/').last;
//       // Reference storageRef = FirebaseStorage.instance.ref().child('uploads/$fileName');
//       // await storageRef.putFile(_media!);
//       // String downloadUrl = await storageRef.getDownloadURL();
//
//       // ScaffoldMessenger.of(context).showSnackBar(
//       // SnackBar(content: Text('Upload successful! URL: $downloadUrl')),
//       // );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Upload failed: $e')),
//       );
//     }
//
//     setState(() => _isUploading = false);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Upload Photo & Video")),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _media != null
//                 ? isVideo(_media!)
//                 ? Icon(Icons.video_library, size: 100)
//                 : Image.file(_media!, height: 200)
//                 : Text("No media selected"),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () => _pickMedia(ImageSource.gallery),
//               child: Text("Pick Image"),
//             ),
//             ElevatedButton(
//               onPressed: () => _pickMedia(ImageSource.gallery, isVideo: true),
//               child: Text("Pick Video"),
//             ),
//             ElevatedButton(
//               onPressed: _isUploading ? null : _uploadMedia,
//               child: _isUploading ? CircularProgressIndicator() : Text("Upload"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   bool isVideo(File file) {
//     return file.path.endsWith('.mp4') || file.path.endsWith('.mov');
//   }
// }




// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ImageTransparencyDemo(),
//     );
//   }
// }
//
// class ImageTransparencyDemo extends StatefulWidget {
//   @override
//   _ImageTransparencyDemoState createState() => _ImageTransparencyDemoState();
// }
//
// class _ImageTransparencyDemoState extends State<ImageTransparencyDemo> {
//   double _opacityValue = 1.0; // Initial opacity value (1.0 means fully visible)
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image Transparency Demo'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             // Image with adjustable opacity
//             Opacity(
//               opacity: _opacityValue,
//               child: Image.asset(
//                 'assets/images/popup-header-bg.png',
//                 width: 200,
//                 height: 200,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             SizedBox(height: 20),
//             // Slider to adjust opacity
//             Slider(
//               value: _opacityValue,
//               min: 0.0,
//               max: 1.0,
//               onChanged: (newValue) {
//                 setState(() {
//                   _opacityValue = newValue;
//                 });
//               },
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Opacity: ${(_opacityValue * 100).toStringAsFixed(0)}%',
//               style: TextStyle(fontSize: 16),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: WatermarkImageDemo(),
//     );
//   }
// }
//
// class WatermarkImageDemo extends StatefulWidget {
//   @override
//   _WatermarkImageDemoState createState() => _WatermarkImageDemoState();
// }
//
// class _WatermarkImageDemoState extends State<WatermarkImageDemo> {
//   File? _selectedImage; // Image selected from the gallery
//   double _opacityValue = 0.5; // Opacity of the watermark
//
//   // Function to pick an image from the gallery
//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedFile != null) {
//       setState(() {
//         _selectedImage = File(pickedFile.path);
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Watermark Image Demo'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             // Display selected image with watermark
//             if (_selectedImage != null)
//               Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Image.file(
//                     _selectedImage!,
//                     width: 300,
//                     height: 300,
//                     fit: BoxFit.cover,
//                   ),
//                   Opacity(
//                     opacity: _opacityValue,
//                     child: Image.asset(
//                       'assets/images/popup-header-bg.png',
//                       width: 150,
//                       height: 150,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ],
//               )
//             else
//               Text('No image selected'),
//
//             SizedBox(height: 20),
//
//             // Slider to adjust watermark opacity
//             Slider(
//               value: _opacityValue,
//               min: 0.0,
//               max: 1.0,
//               onChanged: (newValue) {
//                 setState(() {
//                   _opacityValue = newValue;
//                 });
//               },
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Watermark Opacity: ${(_opacityValue * 100).toStringAsFixed(0)}%',
//               style: TextStyle(fontSize: 16),
//             ),
//
//             SizedBox(height: 20),
//
//             // Button to pick an image from the gallery
//             ElevatedButton(
//               onPressed: _pickImage,
//               child: Text('Select Image from Gallery'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }






// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image/image.dart' as img;
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io';
// import 'package:path/path.dart';  // Add this import for path handling
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: WatermarkImageDemo(),
//     );
//   }
// }
//
// class WatermarkImageDemo extends StatefulWidget {
//   @override
//   _WatermarkImageDemoState createState() => _WatermarkImageDemoState();
// }
//
// class _WatermarkImageDemoState extends State<WatermarkImageDemo> {
//   File? _selectedImage; // Image selected from the gallery
//   double _opacityValue = 0.5; // Opacity of the watermark
//
//   // Function to pick an image from the gallery
//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedFile != null) {
//       setState(() {
//         _selectedImage = File(pickedFile.path);
//       });
//     }
//   }
//
//   // Function to combine images and save the result
//   Future<File?> _combineImages() async {
//     if (_selectedImage == null) return null;
//
//     // Load the selected image
//     final selectedImageBytes = await _selectedImage!.readAsBytes();
//     final selectedImage = img.decodeImage(selectedImageBytes);
//
//     // Load the watermark image
//     final watermarkImageBytes = await rootBundle.load('assets/images/popup-header-bg.png');
//     final watermarkImage = img.decodeImage(watermarkImageBytes.buffer.asUint8List());
//
//     if (selectedImage == null || watermarkImage == null) return null;
//
//     // Resize watermark to fit the selected image (optional)
//     final resizedWatermark = img.copyResize(watermarkImage,
//         width: selectedImage.width ~/ 4, height: selectedImage.height ~/ 4);
//
//     // // Overlay the watermark on the selected image
//     // final combinedImage = img.copyInto(
//     //   selectedImage,
//     //   resizedWatermark,
//     //   dstX: selectedImage.width - resizedWatermark.width - 10, // Position watermark
//     //   dstY: selectedImage.height - resizedWatermark.height - 10,
//     //   blend: true,
//     //   opacity: _opacityValue,
//     // );
//     //
//     //
//     //
//     // // Save the combined image to a temporary file
//     // final directory = await getTemporaryDirectory();
//     // final path = join(directory.path, 'combined_image.png');
//     // final file = File(path);
//     // await file.writeAsBytes(encodePng(combinedImage!));
//
//
//     double x = selectedImage.width - resizedWatermark.width - 20;
//     double y = selectedImage.height - resizedWatermark.height - 20;
//
//     final directory = await getApplicationDocumentsDirectory();
//     final File newFile = File('${directory.path}/watermarked_image.jpg');
//     await newFile.writeAsBytes(img.encodePng(img.compositeImage(selectedImage, resizedWatermark, dstX: x.toInt(), dstY: y.toInt())));
//
//     return newFile;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Watermark Image Demo'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             // Display selected image with watermark
//             if (_selectedImage != null)
//               Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Image.file(
//                     _selectedImage!,
//                     width: 300,
//                     height: 300,
//                     fit: BoxFit.cover,
//                   ),
//
//                 ],
//               )
//             else
//               Text('No image selected'),
//
//             SizedBox(height: 20),
//
//             // Slider to adjust watermark opacity
//             Slider(
//               value: _opacityValue,
//               min: 0.0,
//               max: 1.0,
//               onChanged: (newValue) {
//                 setState(() {
//                   _opacityValue = newValue;
//                 });
//               },
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Watermark Opacity: ${(_opacityValue * 100).toStringAsFixed(0)}%',
//               style: TextStyle(fontSize: 16),
//             ),
//
//             SizedBox(height: 20),
//
//             // Button to pick an image from the gallery
//             ElevatedButton(
//               onPressed: _pickImage,
//               child: Text('Select Image from Gallery'),
//             ),
//
//             SizedBox(height: 20),
//
//             // Button to generate and show the final image
//             ElevatedButton(
//               onPressed: () async {
//                 final combinedImage = await _combineImages();
//                 if (combinedImage != null) {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => FinalImagePage(imageFile: combinedImage),
//                     ),
//                   );
//                 }
//               },
//               child: Text('Generate Final Image'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // Page to display the final combined image
// class FinalImagePage extends StatelessWidget {
//   final File imageFile;
//
//   FinalImagePage({required this.imageFile});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Final Image'),
//       ),
//       body: Center(
//         child: Image.file(
//           imageFile,
//           width: 300,
//           height: 300,
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   }
// }







import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WatermarkImageScreen(),
    );
  }
}

class WatermarkImageScreen extends StatefulWidget {
  @override
  _WatermarkImageScreenState createState() => _WatermarkImageScreenState();
}

class _WatermarkImageScreenState extends State<WatermarkImageScreen> {
  File? _imageFile;
  ui.Image? _watermarkImage;
  double _opacity = 0.5; // Default opacity

  @override
  void initState() {
    super.initState();
    _loadWatermarkImage();
  }

  /// Load watermark image from assets
  Future<void> _loadWatermarkImage() async {
    final ByteData data = await rootBundle.load('assets/images/popup-header-bg.png');
    final Uint8List bytes = data.buffer.asUint8List();
    final Completer<ui.Image> completer = Completer();

    ui.decodeImageFromList(bytes, (ui.Image img) {
      completer.complete(img);
    });

    _watermarkImage = await completer.future;
    setState(() {});
  }

  /// Pick image from gallery
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  /// Apply watermark with selected opacity
  Future<ui.Image> _applyWatermark(ui.Image image) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final paint = Paint()..filterQuality = FilterQuality.high;
    final imageSize = Size(image.width.toDouble(), image.height.toDouble());

    // Draw original image
    canvas.drawImage(image, Offset.zero, paint);

    if (_watermarkImage != null) {
      final paintWatermark = Paint()
        ..color = Colors.white.withOpacity(_opacity) // Dynamic opacity
        ..blendMode = BlendMode.srcOver;

      final double watermarkWidth = imageSize.width * 0.3;
      final double watermarkHeight = (_watermarkImage!.height / _watermarkImage!.width) * watermarkWidth;
      final double dx = imageSize.width - watermarkWidth - 20;
      final double dy = imageSize.height - watermarkHeight - 20;

      final Rect watermarkRect = Rect.fromLTWH(dx, dy, watermarkWidth, watermarkHeight);
      canvas.drawImageRect(
          _watermarkImage!,
          Rect.fromLTWH(0, 0, _watermarkImage!.width.toDouble(), _watermarkImage!.height.toDouble()),
          watermarkRect,
          paintWatermark);
    }

    final picture = recorder.endRecording();
    return picture.toImage(image.width, image.height);
  }

  /// Convert File to ui.Image
  Future<ui.Image> _loadUiImage(File file) async {
    final Uint8List bytes = await file.readAsBytes();
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(bytes, (ui.Image img) {
      completer.complete(img);
    });
    return completer.future;
  }

  /// Navigate to preview page
  Future<void> _navigateToPreview() async {
    if (_imageFile == null) return;

    final ui.Image originalImage = await _loadUiImage(_imageFile!);
    final ui.Image watermarkedImage = await _applyWatermark(originalImage);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PreviewScreen(image: watermarkedImage),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Watermark Image")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imageFile == null
                ? Text("No image selected")
                : FutureBuilder<ui.Image>(
              future: _loadUiImage(_imageFile!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                  return FutureBuilder<ui.Image>(
                    future: _applyWatermark(snapshot.data!),
                    builder: (context, watermarkSnapshot) {
                      if (watermarkSnapshot.connectionState == ConnectionState.done &&
                          watermarkSnapshot.hasData) {
                        return Column(
                          children: [
                            RawImage(image: watermarkSnapshot.data, width: 250),
                            Slider(
                              value: _opacity,
                              min: 0.0,
                              max: 1.0,
                              divisions: 10,
                              label: "Opacity: ${_opacity.toStringAsFixed(1)}",
                              onChanged: (value) {
                                setState(() {
                                  _opacity = value;
                                });
                              },
                            ),
                          ],
                        );
                      }
                      return CircularProgressIndicator();
                    },
                  );
                }
                return CircularProgressIndicator();
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _pickImage, child: Text("Pick Image")),
            ElevatedButton(
              onPressed: _navigateToPreview,
              child: Text("Next Page"),
            ),
          ],
        ),
      ),
    );
  }
}

/// Preview Page
class PreviewScreen extends StatelessWidget {
  final ui.Image image;

  PreviewScreen({required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Final Image")),
      body: Center(
        child: RawImage(image: image),
      ),
    );
  }
}
