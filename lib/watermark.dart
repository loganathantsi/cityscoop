import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ImagePickerScreen(),
    );
  }
}

class ImagePickerScreen extends StatefulWidget {
  @override
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  File? _image;
  File? _watermarkedImage;
  final ImagePicker _picker = ImagePicker();
  double _opacity = 0.5; // Default transparency (50%)

  /// Pick Image from Gallery
  Future<void> _pickImage() async {
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      _addWatermark();
    }
  }

  /// Add Watermark with Adjustable Opacity
  Future<void> _addWatermark() async {
    if (_image == null) return;

    // Load the selected image
    img.Image originalImage = img.decodeImage(await _image!.readAsBytes())!;

    // Load the watermark image (use an asset or external file)
    ByteData data = await rootBundle.load('assets/images/ic_calendar.png');
    Uint8List bytes = data.buffer.asUint8List();
    img.Image watermark = img.decodeImage(bytes)!;

    // Resize watermark
    watermark = img.copyResize(watermark, width: originalImage.width ~/ 5);

// Apply transparency to watermark
    for (int y = 0; y < watermark.height; y++) {
// Apply transparency to watermark
      for (int y = 0; y < watermark.height; y++) {
        for (int x = 0; x < watermark.width; x++) {
          img.Pixel pixel = watermark.getPixel(x, y);

          // Extract RGBA components
          int r = pixel.r.toInt();
          int g = pixel.g.toInt();
          int b = pixel.b.toInt();
          int a = pixel.a.toInt();

          // Apply opacity factor
          int newAlpha = (a * _opacity).toInt().clamp(0, 255);

          // Create a new color with updated alpha
          img.ColorInt32 newColor = img.ColorInt32.rgba(r, g, b, newAlpha);

          // Set the new color back to the image
          watermark.setPixel(x, y, newColor);
        }
      }
    }

    // Composite watermark on bottom-right corner
    int x = originalImage.width - watermark.width - 20;
    int y = originalImage.height - watermark.height - 20;
    img.compositeImage(originalImage, watermark, dstX: x, dstY: y);

    // Save watermarked image
    Uint8List newImageBytes = Uint8List.fromList(img.encodePng(img.compositeImage(originalImage, watermark, dstX: x, dstY: y)));

    final directory = await getApplicationDocumentsDirectory();
    final File newFile = File('${directory.path}/watermarked_image.jpg');
    await newFile.writeAsBytes(newImageBytes);

    setState(() {
      _watermarkedImage = newFile;
    });
  }

  /// Upload Image (Placeholder for Upload Logic)
  Future<void> _uploadImage() async {
    if (_watermarkedImage == null) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Image uploaded successfully!")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Image Watermark & Upload")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image == null
                ? Text("No Image Selected")
                : Image.file(_image!, height: 200),
            SizedBox(height: 20),
            _watermarkedImage == null
                ? Text("No Watermark Added")
                : Image.file(_watermarkedImage!, height: 200),
            SizedBox(height: 20),
            Text("Watermark Transparency: ${(100 * _opacity).toInt()}%"),
            Slider(
              value: _opacity,
              min: 0.0,
              max: 1.0,
              divisions: 10,
              label: "${(100 * _opacity).toInt()}%",
              onChanged: (double value) {
                setState(() {
                  _opacity = value;
                });
                _addWatermark();
              },
            ),
            ElevatedButton(onPressed: _pickImage, child: Text("Pick Image")),
            ElevatedButton(onPressed: _uploadImage, child: Text("Upload Image")),
          ],
        ),
      ),
    );
  }
}