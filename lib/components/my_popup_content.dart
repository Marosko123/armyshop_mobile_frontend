import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

import '../common/armyshop_colors.dart';

class MyPopupContent extends StatefulWidget {
  final IconData icon;
  final String label;
  final String? value;
  final bool? isNumeric;
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
          ],
        ],
      ),
    );
  }
}
