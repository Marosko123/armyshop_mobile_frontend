import 'package:armyshop_mobile_frontend/common/converters.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../common/armyshop_colors.dart';
import '../common/global_variables.dart';

class MyTextfield extends StatefulWidget {
  final IconData icon;
  final String label;
  final String? value;
  final bool? isNumeric;
  final Function saveCallback;

  const MyTextfield(
      {Key? key,
      required this.icon,
      required this.label,
      required this.value,
      required this.saveCallback,
      this.isNumeric = false})
      : super(key: key);

  @override
  State<MyTextfield> createState() {
    return _MyTextfieldState();
  }
}

class _MyTextfieldState extends State<MyTextfield> {
  String tmpVal = '';
  String error = '';

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
