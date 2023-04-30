import 'dart:convert';
import 'dart:io';

import 'package:armyshop_mobile_frontend/common/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path_provider/path_provider.dart';

import '../common/armyshop_colors.dart';
import '../screens/photo_screen.dart';

class MyPopupContent extends StatefulWidget {
  final IconData icon;
  final String label;
  final String? value;
  final bool? isNumeric;
  final bool? isImage;
  final bool? isAddress;
  final Function returnCoordinatesCallback;
  final Function returnNewValueCallback;

  const MyPopupContent(
      {Key? key,
      required this.icon,
      required this.label,
      required this.value,
      required this.returnCoordinatesCallback,
      required this.returnNewValueCallback,
      this.isNumeric = false,
      this.isImage = false,
      this.isAddress = false})
      : super(key: key);

  @override
  State<MyPopupContent> createState() {
    return _MyPopupContentState();
  }
}

class _MyPopupContentState extends State<MyPopupContent> {
  String error = '';
  String currentLocation = 'Get My Current Location';
  late double lat = 0;
  late double long = 0;
  late Future<File> imageFile;

  @override
  void initState() {
    super.initState();

    if (widget.isImage! && GlobalVariables.user.licensePicture.isNotEmpty) {
      imageFile = base64ToFile(GlobalVariables.user.licensePicture);
    } else if (widget.isImage! &&
        GlobalVariables.tmpData != null &&
        GlobalVariables.tmpData['picture'].isNotEmpty) {
      imageFile = base64ToFile(GlobalVariables.tmpData['picture']);
    }
  }

  Future<Position> getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      error = 'Location services are disabled.';
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        error = 'Location permissions are disabled.';
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      error =
          'Location permissions are permanently denied, we cannot request permissions.';
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<File> base64ToFile(String base64String) async {
    final decodedBytes = base64Decode(base64String);

    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/military_passport.png';
    final file = File(filePath);
    await file.writeAsBytes(decodedBytes);

    return file;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListBody(
        children: [
          Text(
            'Your current ${widget.label}:',
            style: TextStyle(color: ArmyshopColors.textColor),
          ),
          if (widget.isImage!) ...[
            if (GlobalVariables.user.licensePicture.isNotEmpty ||
                GlobalVariables.tmpData['picture'].isNotEmpty)
              FutureBuilder<File>(
                future: imageFile,
                builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      return Image.file(snapshot.data!);
                    } else {
                      return const Text('Empty file');
                    }
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            SizedBox(
              width: 300,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: ArmyshopColors.dividerColor,
                            width: 2.0,
                          ),
                        ),
                      ),
                      child: Text(
                        'Get a new photo',
                        style: TextStyle(color: ArmyshopColors.textColor),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      GlobalVariables.tmpData['previousScreen'] =
                          'MyProfileScreen';

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PhotoScreen(),
                        ),
                      ).then((returnValue) {
                        if (returnValue != null) {
                          if (GlobalVariables.tmpData['picture'].isNotEmpty) {
                            imageFile = base64ToFile(
                                GlobalVariables.tmpData['picture']);
                          }
                          setState(() {});
                        }
                      });
                    },
                    icon: Icon(
                      Icons.camera_alt_outlined,
                      color: ArmyshopColors.textColor,
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: ArmyshopColors.dividerColor,
                    width: 2.0,
                  ),
                ),
              ),
              child: TextField(
                autofocus: true,
                style: TextStyle(color: ArmyshopColors.textColor),
                keyboardType: widget.isNumeric! ? TextInputType.number : null,
                inputFormatters: widget.isNumeric!
                    ? <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'^\d*'))
                      ]
                    : null,
                onChanged: (value) {
                  widget.returnNewValueCallback(value);
                },
              ),
            ),
            Text(
              error,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (widget.isAddress!) ...[
              const Text('Or'),
              SizedBox(
                width: 300,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: ArmyshopColors.dividerColor,
                              width: 2.0,
                            ),
                          ),
                        ),
                        child: Text(
                          currentLocation,
                          style: TextStyle(color: ArmyshopColors.textColor),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        getLocation().then((value) {
                          lat = value.latitude;
                          long = value.longitude;
                          widget.returnCoordinatesCallback(lat, long);
                          setState(() {});
                        });
                      },
                      icon: Icon(
                        Icons.gps_fixed,
                        color: ArmyshopColors.textColor,
                      ),
                    ),
                  ],
                ),
              ),
              if (lat != 0 && long != 0) ...[
                Text(
                  'Latitude: $lat',
                  style: TextStyle(color: ArmyshopColors.textColor),
                ),
                Text(
                  'Longitude: $long',
                  style: TextStyle(color: ArmyshopColors.textColor),
                )
              ]
            ]
          ],
        ],
      ),
    );
  }
}
