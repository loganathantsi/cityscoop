// import 'dart:io';
// import 'dart:ui' as ui;
// import 'dart:typed_data';
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: WatermarkImageScreen(),
//     );
//   }
// }
//
// class WatermarkImageScreen extends StatefulWidget {
//   @override
//   _WatermarkImageScreenState createState() => _WatermarkImageScreenState();
// }
//
// class _WatermarkImageScreenState extends State<WatermarkImageScreen> {
//   File? _imageFile;
//   ui.Image? _watermarkImage;
//   double _opacity = 0.5; // Default opacity
//
//   @override
//   void initState() {
//     super.initState();
//     _loadWatermarkImage();
//   }
//
//   /// Load watermark image from assets
//   Future<void> _loadWatermarkImage() async {
//     final ByteData data = await rootBundle.load('assets/images/popup-header-bg.png');
//     final Uint8List bytes = data.buffer.asUint8List();
//     final Completer<ui.Image> completer = Completer();
//
//     ui.decodeImageFromList(bytes, (ui.Image img) {
//       completer.complete(img);
//     });
//
//     _watermarkImage = await completer.future;
//     setState(() {});
//   }
//
//   /// Pick image from gallery
//   Future<void> _pickImage() async {
//     final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = File(pickedFile.path);
//       });
//     }
//   }
//
//   /// Apply watermark with selected opacity
//   Future<ui.Image> _applyWatermark(ui.Image image) async {
//     final recorder = ui.PictureRecorder();
//     final canvas = Canvas(recorder);
//     final paint = Paint()..filterQuality = FilterQuality.high;
//     final imageSize = Size(image.width.toDouble(), image.height.toDouble());
//
//     // Draw original image
//     canvas.drawImage(image, Offset.zero, paint);
//
//     if (_watermarkImage != null) {
//       final paintWatermark = Paint()
//         ..color = Colors.white.withOpacity(_opacity) // Dynamic opacity
//         ..blendMode = BlendMode.srcOver;
//
//       final double watermarkWidth = imageSize.width * 0.3;
//       final double watermarkHeight = (_watermarkImage!.height / _watermarkImage!.width) * watermarkWidth;
//       final double dx = imageSize.width - watermarkWidth - 20;
//       final double dy = imageSize.height - watermarkHeight - 20;
//
//       final Rect watermarkRect = Rect.fromLTWH(dx, dy, watermarkWidth, watermarkHeight);
//       canvas.drawImageRect(
//           _watermarkImage!,
//           Rect.fromLTWH(0, 0, _watermarkImage!.width.toDouble(), _watermarkImage!.height.toDouble()),
//           watermarkRect,
//           paintWatermark);
//     }
//
//     final picture = recorder.endRecording();
//     return picture.toImage(image.width, image.height);
//   }
//
//   /// Convert File to ui.Image
//   Future<ui.Image> _loadUiImage(File file) async {
//     final Uint8List bytes = await file.readAsBytes();
//     final Completer<ui.Image> completer = Completer();
//     ui.decodeImageFromList(bytes, (ui.Image img) {
//       completer.complete(img);
//     });
//     return completer.future;
//   }
//
//   /// Navigate to preview page
//   Future<void> _navigateToPreview() async {
//     if (_imageFile == null) return;
//
//     final ui.Image originalImage = await _loadUiImage(_imageFile!);
//     final ui.Image watermarkedImage = await _applyWatermark(originalImage);
//
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => PreviewScreen(image: watermarkedImage),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Watermark Image")),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _imageFile == null
//                 ? Text("No image selected")
//                 : FutureBuilder<ui.Image>(
//               future: _loadUiImage(_imageFile!),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
//                   return FutureBuilder<ui.Image>(
//                     future: _applyWatermark(snapshot.data!),
//                     builder: (context, watermarkSnapshot) {
//                       if (watermarkSnapshot.connectionState == ConnectionState.done &&
//                           watermarkSnapshot.hasData) {
//                         return Column(
//                           children: [
//                             RawImage(image: watermarkSnapshot.data, width: 250),
//                             Slider(
//                               value: _opacity,
//                               min: 0.0,
//                               max: 1.0,
//                               divisions: 10,
//                               label: "Opacity: ${_opacity.toStringAsFixed(1)}",
//                               onChanged: (value) {
//                                 setState(() {
//                                   _opacity = value;
//                                 });
//                               },
//                             ),
//                           ],
//                         );
//                       }
//                       return CircularProgressIndicator();
//                     },
//                   );
//                 }
//                 return CircularProgressIndicator();
//               },
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(onPressed: _pickImage, child: Text("Pick Image")),
//             ElevatedButton(
//               onPressed: _navigateToPreview,
//               child: Text("Next Page"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// /// Preview Page
// class PreviewScreen extends StatelessWidget {
//   final ui.Image image;
//
//   PreviewScreen({required this.image});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Final Image")),
//       body: Center(
//         child: RawImage(image: image),
//       ),
//     );
//   }
// }