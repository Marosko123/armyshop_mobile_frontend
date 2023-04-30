import 'package:flutter/material.dart';

import '../common/armyshop_colors.dart';
import '../common/global_variables.dart';
import 'my_popup_content.dart';

class MyTextfield extends StatefulWidget {
  final IconData icon;
  final String label;
  final String? value;
  final bool? isNumeric;
  final bool? isAddress;
  final bool? isImage;
  final Function saveCallback;

  const MyTextfield(
      {Key? key,
      required this.icon,
      required this.label,
      required this.value,
      required this.saveCallback,
      this.isNumeric = false,
      this.isImage = false,
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
  late double lat = 0;
  late double long = 0;

  Future<void> updateUser() async {
    if (tmpVal.isEmpty &&
        lat == 0 &&
        long == 0 &&
        GlobalVariables.tmpData['picture'].isEmpty) return;

    tmpVal = lat != 0
        ? '$lat,$long'
        : GlobalVariables.tmpData['picture'].isEmpty
            ? tmpVal
            : GlobalVariables.tmpData['picture'];

    GlobalVariables.tmpData['picture'] = '';

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
      try {
        error = response['errors'].entries.first.value[0];
      } catch (e) {
        error = response['error'];
      }
      // ignore: use_build_context_synchronously
      showDialogAlert(context);
    }

    setState(() {});
  }

  returnNewValueCallback(String tmpVal) {
    this.tmpVal = tmpVal;
    lat = 0;
    long = 0;
  }

  returnCoordinatesCallback(double lat, double long) {
    this.lat = lat;
    this.long = long;
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
          content: MyPopupContent(
            label: widget.label,
            icon: widget.icon,
            value: widget.value,
            isNumeric: widget.isNumeric,
            isAddress: widget.isAddress,
            isImage: widget.isImage,
            returnCoordinatesCallback: returnCoordinatesCallback,
            returnNewValueCallback: returnNewValueCallback,
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                error = '';
                GlobalVariables.tmpData['picture'] = '';
                Navigator.of(context).pop();
                setState(() {});
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
