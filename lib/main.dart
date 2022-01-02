import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Image Picker Demo'),
    );
  }
}

//create a method to get the image

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  XFile? image;
  final ImagePicker picker = ImagePicker();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            //display semantics here

            Center(
              child: Container(
                child: image != null
                    ? (kIsWeb
                        ? (Image.network(image!.path))
                        : (Image.file(File(image!.path)))) 
                    : Text('Pick an image'),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
      bottomSheet: BottomSheet(
          elevation: 2,
          enableDrag: true,
          animationController: AnimationController(
            vsync: this,
            duration: const Duration(seconds: 3),
          ),
          onClosing: () {
            print('Bottom sheet is closing');
            //close effect for bottom sheet
          },
          builder: (context) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              height: 100,
              child: const Center(
                child: Text('Bottom Sheet'),
              ),
            );
          }),
      //add a bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Add',
        ),
      ]),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: FloatingActionButton(
              onPressed: () async {
                final _pickedFile =
                    await picker.getImage(source: ImageSource.gallery);
                if (_pickedFile != null) {
                  setState(() {
                    image = XFile(_pickedFile.path);
                  });
                }
              },
              child: const Icon(Icons.add_a_photo),
            ),
          ),
          //first floating action button
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.add_photo_alternate),
            ),
          ),
        ],
      ),
    );
  }
}
