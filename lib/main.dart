import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //initialize image as XFile to access ImagePicker
  XFile? image;
  final ImagePicker picker = ImagePicker();
  Future<void> _pickImage(ImageSource source) async {
    final _pickedFile = await picker.getImage(source: source);
    //check if the image is not null
    if (_pickedFile != null) {
      setState(() {
        image = XFile(_pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker Example'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _pickImage(ImageSource.gallery);
        },
        tooltip: 'Pick Image',
        child: const Icon(Icons.add_a_photo),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 200,
                width: 200,
                child: image != null
                    ? (kIsWeb
                        ? (Image.network(image!.path))
                        : (Image.file(File(image!.path))))
                    : const Text('Pick an image'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
