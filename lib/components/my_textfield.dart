import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

import '../common/armyshop_colors.dart';
import '../common/global_variables.dart';

class MyTextfield extends StatefulWidget {
  final IconData icon;
  final String label;
  final String? value;
  final bool? isNumeric;
  final bool? isAddress;
  final Function saveCallback;

  const MyTextfield(
      {Key? key,
      required this.icon,
      required this.label,
      required this.value,
      required this.saveCallback,
      this.isNumeric = false,
      this.isAddress = false})
      : super(key: key);

  @override
  State<MyTextfield> createState() {
    return _MyTextfieldState();
  }
}

class _MyTextfieldState extends State<MyTextfield> {
  String tmpVal = '';
  String error = '';
  String currentLocation = 'Get My Current Location';
  late String lat = '';
  late String long = '';

  Future<void> updateUser() async {
    if (tmpVal.isEmpty) return;

    dynamic response = await GlobalVariables.user.updateValue(
      widget.label,
      tmpVal,
    );

    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();

    if (response['status'] == 200) {
      widget.saveCallback();
      error = '';
    } else {
      error = response['errors'].entries.first.value[0];
      // ignore: use_build_context_synchronously
      showDialogAlert(context);
    }

    setState(() {});
  }

  Future<Position> getLocation() async {
    print('adresa');

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

  Future<void> showDialogAlert(BuildContext context) async {
    return showDialog<void>(
      barrierColor: const Color.fromRGBO(0, 0, 0, 0.5),
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ArmyshopColors.backgroundColor,
          title: Text(
            'Update ${widget.label}',
            style: TextStyle(
              color: ArmyshopColors.textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                  'Enter new ${widget.label}:',
                  style: TextStyle(color: ArmyshopColors.textColor),
                ),
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
                    keyboardType:
                        widget.isNumeric! ? TextInputType.number : null,
                    inputFormatters: widget.isNumeric!
                        ? <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'^\d*'))
                          ]
                        : null,
                    onChanged: (value) {
                      tmpVal = value;
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
                              lat = '${value.latitude}';
                              long = '${value.longitude}';
                              setState(() {
                                currentLocation = '$lat $long';
                              });
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
                  Text(
                    'Latitude: $lat',
                    style: TextStyle(color: ArmyshopColors.textColor),
                  ),
                  Text(
                    'Longitude: $long',
                    style: TextStyle(color: ArmyshopColors.textColor),
                  )
                ],
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                error = '';
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              onPressed: updateUser,
              child: const Text('Apply'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: GestureDetector(
          onTap: () {
            showDialogAlert(context);
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: ArmyshopColors.textColor),
              ),
            ),
            child: Row(
              children: [
                Icon(widget.icon, color: ArmyshopColors.textColor),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      widget.label,
                      style: TextStyle(
                        color: ArmyshopColors.textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Text(
                    widget.value!,
                    style: TextStyle(
                      color: ArmyshopColors.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
