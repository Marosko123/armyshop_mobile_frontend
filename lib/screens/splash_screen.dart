// ignore_for_file: avoid_print

import 'dart:async';

import 'package:armyshop_mobile_frontend/screens/primary_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../common/global_variables.dart';
import '../components/my_button.dart';
import '../common/server_handling/request_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool showLoading = false;
  int _noInternetCounter = 0;
  dynamic _timer;

  void getProducts() async {
    await RequestHandler.getProducts()
        .then((value) =>
            Navigator.of(context).popAndPushNamed(PrimaryPage.routeName))
        // ignore: invalid_return_type_for_catch_error
        .catchError(
          (e) => {
            print(e),
          },
        );

    _noInternetCounter++;
    print(_noInternetCounter);

    if (_noInternetCounter >= 3) {
      try {
        return setState(() {
          GlobalVariables.isConnectedToServer = false;
          showLoading = false;
          _timer.cancel();
        });
      } catch (e) {
        print(e);
      }
    }

    await Future.delayed(const Duration(seconds: 1), () => getProducts());
  }

  void continueOfflinePressed() {
    Navigator.of(context).popAndPushNamed(PrimaryPage.routeName);
  }

  @override
  void initState() {
    super.initState();

    _timer = Timer(const Duration(seconds: 3),
        () => {showLoading = true, setState(() {}), getProducts()});
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.green[900],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Armyshop',
              style: GoogleFonts.pacifico(
                color: const Color(0xff4e8489),
                fontSize: 27,
              ),
            ),
            if (showLoading)
              const SizedBox(
                height: 20.0,
                width: 20.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Color(0xff4e8489),
                  ),
                  strokeWidth: 1.5,
                ),
              ),
            if (showLoading)
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  'Loading App',
                  style: GoogleFonts.poppins(),
                ),
              ),
            if (!GlobalVariables.isConnectedToServer)
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  'Connection to the server may not be available',
                  style: GoogleFonts.poppins(),
                ),
              ),
            if (!GlobalVariables.isConnectedToServer)
              MyButton(
                text: 'Continue offline',
                onTap: continueOfflinePressed,
              ),
          ],
        ),
      ),
    );
  }
}
