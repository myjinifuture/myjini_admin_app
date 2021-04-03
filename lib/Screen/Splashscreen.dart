import 'package:flutter/material.dart';
import 'dart:async';

class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 4), () async {
      Navigator.pushReplacementNamed(context, '/LoginScreen');

      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setString(constant.Session.ProfileUpdateFlag, "true");
      // String MemberId = prefs.getString(constant.Session.Member_Id);
      // String Verified = prefs.getString(constant.Session.IsVerified);
      // if (MemberId != null && MemberId != "")
      //   Navigator.pushReplacementNamed(context, '/HomeScreen');
      // else {
      //  Navigator.pushReplacementNamed(context, '/IntroScreen');
      //  // Navigator.pushReplacementNamed(context, '/LoginScreen');
      // }
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                'assets/background.png',
                fit: BoxFit.fill,
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 60, right: 40, left: 60),
                child: Image.asset(
                  'assets/gini.png',
                  height: MediaQuery.of(context).size.height / 1.6,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/myginitext.png',
                  height: 100,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
