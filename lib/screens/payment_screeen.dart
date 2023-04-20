import 'dart:async';

import 'package:armyshop_mobile_frontend/common/global_variables.dart';
import 'package:armyshop_mobile_frontend/common/user_authenticator.dart';
import 'package:flutter/material.dart';


class PaymentScreen extends StatefulWidget {
  
  const PaymentScreen({Key? key}) : super(key: key);

  static const routeName = '/payment-screen';

  @override
  PaymentScreenState createState() => PaymentScreenState();
}

class PaymentScreenState extends State<PaymentScreen> {

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Chat'),
    );
  }
}
