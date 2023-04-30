// ignore_for_file: avoid_print

import 'dart:async';

import 'package:armyshop_mobile_frontend/common/global_variables.dart';
import 'package:armyshop_mobile_frontend/common/notifications/notification_service.dart';
// import 'package:armyshop_mobile_frontend/common/user_authenticator.dart';
import 'package:armyshop_mobile_frontend/screens/primary_page.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../common/armyshop_colors.dart';
import '../common/notifications/notifications.dart';

enum DeliveryMethod { standard, express, nextDay }

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  static const routeName = '/payment-screen';

  @override
  PaymentScreenState createState() => PaymentScreenState();
}

class PaymentScreenState extends State<PaymentScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();

  DeliveryMethod? _deliveryMethod = DeliveryMethod.standard;

  @override
  void initState() {
    super.initState();
    _firstNameController.text = GlobalVariables.user.firstName;
    _lastNameController.text = GlobalVariables.user.lastName;
    _emailController.text = GlobalVariables.user.email;
    _addressController.text = GlobalVariables.user.address;
    _phoneController.text = GlobalVariables.user.telephone.toString();
  }

  void showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // send successful payment notification
        NotificationService().scheduleNotification(
            notification: Notifications.getRandomNotification(
                Notifications.purchaseNotifications),
            scheduledDate: DateTime.now().add(const Duration(seconds: 10)));

        // return the Dialog widget
        return const AlertDialog(
          title: Text('Thank you for your order!'),
          content: Text('You will be redirected in 2 seconds'),
        );
      },
    );

    // redirect to another page after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).popAndPushNamed(PrimaryPage.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const SizedBox(height: 10),
        // Header
        Row(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: BackButton(
                color: ArmyshopColors.textColor,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 40.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Billing information',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ArmyshopColors.textColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Address',
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone',
                ),
              ),
              const SizedBox(height: 32.0),
              Column(
                children: [
                  ListTile(
                    title: const Text('Standard Delivery'),
                    leading: Radio(
                      value: DeliveryMethod.standard,
                      groupValue: _deliveryMethod,
                      onChanged: (DeliveryMethod? value) {
                        setState(() {
                          _deliveryMethod = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Express Delivery'),
                    leading: Radio(
                      value: DeliveryMethod.express,
                      groupValue: _deliveryMethod,
                      onChanged: (DeliveryMethod? value) {
                        setState(() {
                          _deliveryMethod = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Next Day Delivery'),
                    leading: Radio(
                      value: DeliveryMethod.nextDay,
                      groupValue: _deliveryMethod,
                      onChanged: (DeliveryMethod? value) {
                        setState(() {
                          _deliveryMethod = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  // create new order
                  print('First Name: ${_firstNameController.text}');
                  print('Last Name: ${_lastNameController.text}');
                  print('Email: ${_emailController.text}');
                  print('Phone: ${_phoneController.text}');
                  showPopup(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ArmyshopColors.buttonColor,
                ),
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
