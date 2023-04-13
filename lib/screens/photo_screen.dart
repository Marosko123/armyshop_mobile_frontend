// ignore_for_file: avoid_print

import 'dart:io';

import 'package:armyshop_mobile_frontend/screens/login_register_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

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

  void submitPhoto() async {
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = '${directory.path}/military_passport.png';

    await imageFile!.copy(imagePath);

    // TODO: after photo publishing set the military_passport_checkbox to true
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginRegisterScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 10),

          Row(
            children: const [
              Align(
                alignment: Alignment.centerLeft,
                child: BackButton(),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 40.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Military passport',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // divider between the back button and the text
          const Divider(
            color: Colors.grey,
            thickness: 1,
          ),

          // text
          const Text(
            'Take a picture of your military passport',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),

          // space between the text and the image
          const SizedBox(height: 50),

          // image
          imageFile != null
              ? Image.file(imageFile!)
              : Icon(
                  Icons.camera_enhance_rounded,
                  color: Colors.green,
                  size: MediaQuery.of(context).size.width * 0.6,
                ),

          // repeat photo button
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: ElevatedButton(
              onPressed: () {
                getFromCamera();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.purple),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.all(12),
                ),
                textStyle: MaterialStateProperty.all(
                  const TextStyle(fontSize: 16),
                ),
              ),
              child: Text(imageFile == null ? 'Take a photo' : 'Change photo'),
            ),
          ),

          // submit photo button
          if (imageFile != null)
            Padding(
              padding:
                  const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30),
              child: ElevatedButton(
                onPressed: () {
                  submitPhoto();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.all(12),
                  ),
                  textStyle: MaterialStateProperty.all(
                    const TextStyle(fontSize: 16),
                  ),
                ),
                child: const Text('Submit photo'),
              ),
            )
        ],
      ),
    );
  }
}
