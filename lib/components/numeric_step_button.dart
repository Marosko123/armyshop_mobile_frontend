import 'package:flutter/material.dart';

import '../common/armyshop_colors.dart';

class NumericStepButton extends StatefulWidget {
  final int minValue;
  final int maxValue;
  final int defaultValue;

  final ValueChanged<int> onChanged;

  const NumericStepButton(
      {Key? key,
      this.minValue = 0,
      this.maxValue = 10,
      this.defaultValue = 1,
      required this.onChanged})
      : super(key: key);

  @override
  State<NumericStepButton> createState() {
    return _NumericStepButtonState();
  }
}

class _NumericStepButtonState extends State<NumericStepButton> {
  late int counter = 0;

  @override
  void initState() {
    super.initState();
    counter = widget.defaultValue; // Initialize counter with defaultValue
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 15,
      width: 111,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(
              Icons.remove,
              color: ArmyshopColors.textColor,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 0,
            ),
            iconSize: 18.0,
            color: Theme.of(context).primaryColor,
            onPressed: () {
              setState(() {
                if (counter > widget.minValue) {
                  counter--;
                }
                widget.onChanged(counter);
              });
            },
          ),
          Text(
            '$counter',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ArmyshopColors.textColor,
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.add,
              color: ArmyshopColors.textColor,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 0,
            ),
            iconSize: 18.0,
            color: Theme.of(context).primaryColor,
            onPressed: () {
              setState(() {
                if (counter < widget.maxValue) {
                  counter++;
                }
                widget.onChanged(counter);
              });
            },
          ),
        ],
      ),
    );
  }
}
