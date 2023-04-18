import 'package:flutter/material.dart';

import '../common/armyshop_colors.dart';
import '../models/user.dart';

// ignore: must_be_immutable
class MyScrollList extends StatefulWidget {
  final List<User> users;
  late List<bool> isCheckedList = [];
  final Function callback;

  MyScrollList({Key? key, required this.users, required this.callback})
      : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<MyScrollList> createState() {
    for (var element in users) {
      isCheckedList.add(false);
    }
    callback(isCheckedList);
    return _MyScrollListState();
  }
}

class _MyScrollListState extends State<MyScrollList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 100,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.users.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: const EdgeInsets.all(0),
            title: Text(
              '${widget.users[index].firstName} ${widget.users[index].lastName}',
              style: TextStyle(color: ArmyshopColors.popupTextColor),
            ),
            value: widget.isCheckedList[index],
            onChanged: (bool? value) {
              setState(() {
                widget.isCheckedList[index] = value!;
                widget.callback(widget.isCheckedList);
              });
            },
          );
        },
      ),
    );
  }
}
