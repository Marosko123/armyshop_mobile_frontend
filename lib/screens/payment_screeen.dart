// ignore_for_file: avoid_print

import 'package:armyshop_mobile_frontend/common/global_variables.dart';
import 'package:flutter/material.dart';

import '../common/armyshop_colors.dart';
import '../common/dialogs.dart';

enum DeliveryMethod { standard, express, nextDay }

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  static const routeName = '/payment-screen';

  @override
  PaymentScreenState createState() => PaymentScreenState();
}

class PaymentScreenState extends State<PaymentScreen> {
  final _firstNameController =
      TextEditingController(text: GlobalVariables.user.firstName);
  final _lastNameController =
      TextEditingController(text: GlobalVariables.user.lastName);
  final _emailController =
      TextEditingController(text: GlobalVariables.user.email);
  final _addressController =
      TextEditingController(text: GlobalVariables.user.address);
  final _phoneController =
      TextEditingController(text: GlobalVariables.user.telephone.toString());

  DeliveryMethod? _deliveryMethod = DeliveryMethod.standard;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const SizedBox(height: 10),
        // Header
        Row(
          children: const [
            Align(
              alignment: Alignment.centerLeft,
              child: BackButton(
                color: Colors.black,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 40.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Billing information',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
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
                  Dialogs.showSuccessfulPaymentPopup(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
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
