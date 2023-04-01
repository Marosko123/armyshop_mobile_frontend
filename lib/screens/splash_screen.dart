import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<SplashScreen> {
  bool showLoading = false;
  dynamic _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer(
        const Duration(seconds: 3),
        () => {
              showLoading = true,
              setState(() {}),
            });
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
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xff4e8489)),
                  strokeWidth: 1.5,
                ),
              ),
            if (showLoading)
              Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text('Loading Sellers', style: GoogleFonts.poppins()))
          ],
        ),
      ),
    );
  }
}
