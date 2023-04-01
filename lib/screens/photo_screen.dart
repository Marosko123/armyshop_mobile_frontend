// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoScreen extends StatefulWidget {
  const PhotoScreen({super.key});

  @override
  PhotoScreenState createState() => PhotoScreenState();
}

class PhotoScreenState extends State<PhotoScreen> {
  File? imageFile;

  void getFromCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      imageFile = File(pickedFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        SizedBox(height: 50),
        imageFile != null
            ? Container(child: Image.file(imageFile!))
            : Container(
                child: Icon(
                Icons.camera_enhance_rounded,
                color: Colors.green,
                size: MediaQuery.of(context).size.width * 0.6,
              )),
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: ElevatedButton(
            onPressed: () {
              getFromCamera();
            },
            child: Text('Take a photo'),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.purple),
                padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                textStyle: MaterialStateProperty.all(TextStyle(fontSize: 16))),
          ),
        )
      ],
    ));
  }
}
